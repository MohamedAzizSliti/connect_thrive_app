import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_thrive_app/services/forum_provider.dart';
import 'package:connect_thrive_app/models/forum_models.dart';
import 'package:connect_thrive_app/screens/forum_posts_screen.dart';
import 'package:connect_thrive_app/screens/create_forum_screen.dart';

class ForumsScreen extends StatefulWidget {
  const ForumsScreen({super.key});

  @override
  State<ForumsScreen> createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadForums();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh forums when returning to this screen
    context.read<ForumProvider>().loadAllForums();
  }

  Future<void> _loadForums() async {
    final forumProvider = context.read<ForumProvider>();
    await forumProvider.loadAllForums();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Community Forums'),
          bottom: const TabBar(
            tabs: [Tab(text: 'All Forums'), Tab(text: 'My Forums')],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateForumScreen()),
                );
                // Refresh forums when returning from creation
                await context.read<ForumProvider>().loadAllForums();
              },
            ),
          ],
        ),
        body: Consumer<ForumProvider>(
          builder: (context, forumProvider, child) {
            if (forumProvider.isLoading && forumProvider.allForums.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (forumProvider.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${forumProvider.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        forumProvider.loadAllForums();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return TabBarView(
              children: [
                _buildAllForumsTab(context.read<ForumProvider>()),
                _buildMyForumsTab(context.read<ForumProvider>()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAllForumsTab(ForumProvider forumProvider) {
    if (forumProvider.isLoading && forumProvider.allForums.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (forumProvider.error != null && forumProvider.allForums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('Error: ${forumProvider.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: forumProvider.loadAllForums,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (forumProvider.allForums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.forum_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No forums available yet'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: forumProvider.loadAllForums,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: forumProvider.loadAllForums,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: forumProvider.allForums.length,
        itemBuilder: (context, index) {
          final forum = forumProvider.allForums[index];
          return _buildForumCard(forum, forumProvider);
        },
      ),
    );
  }

  Widget _buildMyForumsTab(ForumProvider forumProvider) {
    if (forumProvider.isLoading && forumProvider.myForums.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (forumProvider.error != null && forumProvider.myForums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text('Error: ${forumProvider.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: forumProvider.loadAllForums,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (forumProvider.myForums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.group_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('You haven\'t joined any forums yet'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                DefaultTabController.of(context).animateTo(0);
              },
              child: const Text('Browse Forums'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: forumProvider.loadAllForums,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: forumProvider.myForums.length,
        itemBuilder: (context, index) {
          final forum = forumProvider.myForums[index];
          return _buildForumCard(forum, forumProvider, isJoined: true);
        },
      ),
    );
  }

  Widget _buildForumCard(
    Forum forum,
    ForumProvider forumProvider, {
    bool isJoined = false,
  }) {
    final isUserJoined =
        isJoined || forumProvider.myForums.any((f) => f.id == forum.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(forum.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forum.description,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              'Created by ${forum.createdBy}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        trailing: ElevatedButton(
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
          child: Text(forum.isMember ? 'View' : 'Join'),
        ),
        onTap: () {
          if (forum.isMember) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ForumPostsScreen(forum: forum)),
            );
          }
        },
      ),
    );
  }
}
