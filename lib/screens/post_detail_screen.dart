import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_thrive_app/services/forum_provider.dart';
import 'package:connect_thrive_app/models/forum_models.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;
  final String postTitle;
  final String forumId;

  const PostDetailScreen({
    super.key,
    required this.postId,
    required this.postTitle,
    required this.forumId,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class ThreadedReply {
  final ForumReply reply;
  final List<ThreadedReply> children;

  ThreadedReply({required this.reply, required this.children});
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _replyController = TextEditingController();
  String? _replyingToReplyId;
  bool _isLoadingPost = true;
  ForumPost? _currentPost;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPostAndReplies();
    });
  }

  Future<void> _loadPostAndReplies() async {
    final forumProvider = context.read<ForumProvider>();
    await forumProvider.loadPostReplies(widget.postId);

    // Try to find the post in current forum posts
    final post = forumProvider.currentForumPosts.firstWhere(
      (p) => p.id == widget.postId,
      orElse:
          () => ForumPost(
            id: widget.postId,
            title: widget.postTitle,
            content: 'Loading...',
            authorId: 'Unknown',
            forumId: widget.forumId,
            createdAt: DateTime.now(),
          ),
    );

    setState(() {
      _currentPost = post;
      _isLoadingPost = false;
    });
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  Future<void> _submitReply(ForumProvider forumProvider) async {
    final content = _replyController.text.trim();

    if (content.isEmpty) return;

    try {
      await forumProvider.createReply(
        postId: widget.postId,
        content: content,
        parentReplyId: _replyingToReplyId,
      );
      _replyController.clear();
      _replyingToReplyId = null;
      FocusScope.of(context).unfocus();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error creating reply: $e')));
    }
  }

  void _showReplyDialog(String parentReplyId) {
    setState(() {
      _replyingToReplyId = parentReplyId;
    });
    // Scroll to input field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Ensure the reply input is visible
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPost) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(_currentPost?.title ?? 'Post')),
      body: Consumer<ForumProvider>(
        builder: (context, forumProvider, child) {
          return Column(
            children: [
              // Post content
              if (_currentPost != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentPost!.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'By ${_currentPost!.authorId} • ${_currentPost!.createdAt.toString().substring(0, 16)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(_currentPost!.content),
                        ],
                      ),
                    ),
                  ),
                ),

              // Replies section
              Expanded(child: _buildRepliesList(forumProvider)),

              // Reply input
              _buildReplyInput(forumProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRepliesList(ForumProvider forumProvider) {
    if (forumProvider.isLoading && forumProvider.currentPostReplies.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (forumProvider.error != null &&
        forumProvider.currentPostReplies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${forumProvider.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => forumProvider.loadPostReplies(widget.postId),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Build threaded reply structure
    final threadedReplies = _buildThreadedReplies(
      forumProvider.currentPostReplies,
    );

    if (threadedReplies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No replies yet. Be the first to reply!'),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => forumProvider.loadPostReplies(widget.postId),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: threadedReplies.length,
        itemBuilder: (context, index) {
          return _buildThreadedReplyItem(threadedReplies[index]);
        },
      ),
    );
  }

  List<ThreadedReply> _buildThreadedReplies(List<ForumReply> allReplies) {
    // Create a map of children by parent ID
    final childrenMap = <String?, List<ForumReply>>{};

    // Group replies by their parent
    for (final reply in allReplies) {
      final parentId = reply.parentReplyId;
      if (!childrenMap.containsKey(parentId)) {
        childrenMap[parentId] = [];
      }
      childrenMap[parentId]!.add(reply);
    }

    // Sort children by creation time
    for (final children in childrenMap.values) {
      children.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    // Build threaded structure starting with top-level replies (parentReplyId == null)
    final topLevelReplies = childrenMap[null] ?? [];

    return topLevelReplies
        .map((reply) => _buildReplyThread(reply, childrenMap))
        .toList();
  }

  ThreadedReply _buildReplyThread(
    ForumReply reply,
    Map<String?, List<ForumReply>> childrenMap,
  ) {
    final children = <ThreadedReply>[];

    // Find all direct children of this reply
    final childReplies = childrenMap[reply.id] ?? [];

    // Recursively build the thread for each child
    for (final childReply in childReplies) {
      children.add(_buildReplyThread(childReply, childrenMap));
    }

    return ThreadedReply(reply: reply, children: children);
  }

  Widget _buildThreadedReplyItem(ThreadedReply threadedReply) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReplyItem(threadedReply.reply),
        if (threadedReply.children.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 24.0),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey.shade300, width: 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children:
                    threadedReply.children
                        .map((child) => _buildThreadedReplyItem(child))
                        .toList(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildReplyItem(ForumReply reply) {
    final leftPadding = reply.depth * 16.0;
    final maxDepth = 5; // Limit nesting depth
    final actualPadding = leftPadding.clamp(0.0, maxDepth * 16.0);

    return Container(
      margin: EdgeInsets.only(left: actualPadding, bottom: 8),
      child: Card(
        elevation: reply.depth > 0 ? 1 : 2,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side:
              reply.depth > 0
                  ? BorderSide(color: Colors.grey.shade200, width: 1)
                  : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reply thread indicator
              if (reply.depth > 0) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Replying to thread',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
              ],

              Text(reply.content, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'By ${reply.authorId}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTimeAgo(reply.createdAt),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  if (reply.depth < maxDepth) ...[
                    const Spacer(),
                    TextButton(
                      onPressed: () => _showReplyDialog(reply.id),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Reply',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildReplyInput(ForumProvider forumProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_replyingToReplyId != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.reply, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  const Text(
                    'Replying to comment',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 16),
                    onPressed: () {
                      setState(() {
                        _replyingToReplyId = null;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _replyController,
                  decoration: InputDecoration(
                    hintText:
                        _replyingToReplyId != null
                            ? 'Write a reply to comment...'
                            : 'Write a reply...',
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _submitReply(forumProvider),
                icon: const Icon(Icons.send),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
