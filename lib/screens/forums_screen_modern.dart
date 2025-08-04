import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/forum_provider.dart';
import '../models/forum_models.dart';
import 'forum_posts_screen.dart';
import 'create_forum_screen.dart';
import '../l10n/app_localizations.dart';

class ForumsScreen extends StatefulWidget {
  const ForumsScreen({super.key});

  @override
  State<ForumsScreen> createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Defer loading until after the build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadForums();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadForums() async {
    final forumProvider = context.read<ForumProvider>();
    await forumProvider.loadAllForums();
  }

  @override
  Widget build(BuildContext context) {
    
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          localizations.communityForums,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: [
            Tab(text: localizations.allForums),
            Tab(text: localizations.myForums),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildForumsList(false),
          _buildForumsList(true),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateForumScreen()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.add),
        label: Text(localizations.newForum),
      ),
    );
  }

  Widget _buildForumsList(bool showMyForums) {
    return Consumer<ForumProvider>(
      builder: (context, forumProvider, child) {
        final forums = showMyForums ? forumProvider.myForums : forumProvider.allForums;
        
        if (forumProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (forums.isEmpty) {
          return _buildEmptyState(showMyForums, context);
        }

        return RefreshIndicator(
          onRefresh: _loadForums,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: forums.length,
            itemBuilder: (context, index) {
              return _buildModernForumCard(forums[index], forumProvider);
            },
          ),
        );
      },
    );
  }

  Widget _buildModernForumCard(Forum forum, ForumProvider forumProvider) {
    final isJoined = forumProvider.myForums.any((f) => f.id == forum.id);
    final localizations = AppLocalizations.of(context)!;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (forum.isMember) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ForumPostsScreen(forum: forum),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.forum,
                        color: Colors.blue.shade800,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forum.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Created by ${forum.createdBy}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  forum.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.people,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${forum.membersCount}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 14,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${forum.postsCount}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: _buildActionButton(forum, forumProvider, isJoined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(Forum forum, ForumProvider forumProvider, bool isJoined) {
    final localizations = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: () async {
        if (forum.isMember) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ForumPostsScreen(forum: forum),
            ),
          );
        } else {
          await forumProvider.joinLeaveForum(
            forumId: forum.id,
            action: 'join',
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: forum.isMember 
          ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
          : Theme.of(context).colorScheme.primary.withOpacity(0.1),
        foregroundColor: forum.isMember 
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).colorScheme.primary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        forum.isMember ? localizations.viewForum : localizations.joinForum,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool showMyForums, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            showMyForums ? Icons.group_off : Icons.forum_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 20),
          Text(
            showMyForums
                ? localizations.noForumsJoinedYet
                : localizations.noForumsAvailable,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            showMyForums
                ? localizations.joinSomeForumsToSeeThem
                : localizations.beTheFirstToCreateForum,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
          if (!showMyForums) ...[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateForumScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(localizations.createFirstForum),
            ),
          ],
        ],
      ),
    );
  }
}
