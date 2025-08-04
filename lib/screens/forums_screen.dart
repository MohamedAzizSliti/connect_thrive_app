import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_thrive_app/services/forum_provider.dart';
import 'package:connect_thrive_app/models/forum_models.dart';
import 'package:connect_thrive_app/screens/forum_posts_screen.dart';
import 'package:connect_thrive_app/screens/create_forum_screen.dart';
import '../l10n/app_localizations.dart';

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
    final localizations = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(localizations.communityForums),
          bottom: TabBar(
            tabs: [
              Tab(text: localizations.allForums),
              Tab(text: localizations.myForums)
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: localizations.createNewForum,
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
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${localizations.error}: ${forumProvider.error}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        forumProvider.loadAllForums();
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text(localizations.retry),
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

    final localizations = AppLocalizations.of(context)!;
    if (forumProvider.allForums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noForumsAvailable,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                forumProvider.loadAllForums();
              },
              icon: const Icon(Icons.refresh),
              label: Text(localizations.refresh),
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

    final localizations = AppLocalizations.of(context)!;
    if (forumProvider.myForums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noJoinedForums,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                DefaultTabController.of(context).animateTo(0);
              },
              icon: const Icon(Icons.browse_gallery),
              label: Text(localizations.browseForums),
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
    final localizations = AppLocalizations.of(context)!;
    final isUserJoined =
        isJoined || forumProvider.myForums.any((f) => f.id == forum.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forum.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              forum.description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '${localizations.createdBy} ${forum.createdBy}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${forum.membersCount} ${localizations.members}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                ElevatedButton.icon(
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
                  icon: Icon(forum.isMember ? Icons.visibility : Icons.add),
                  label: Text(forum.isMember ? localizations.viewForum : localizations.joinForum),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: forum.isMember
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                    foregroundColor: forum.isMember
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
