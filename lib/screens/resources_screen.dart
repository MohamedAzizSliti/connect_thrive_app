import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/journal_service.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> resources = [];
  bool isLoading = false;
  String searchQuery = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    _fetchJournalEntries();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchJournalEntries() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final result = await JournalService.searchJournalEntries(
        query: searchQuery,
        page: 1,
        limit: 20,
      );

      if (result['success']) {
        final data = result['data'];
        final List<dynamic> newEntries = data['data'] ?? [];

        setState(() {
          resources = newEntries;
          isLoading = false;
        });
      } else {
        // Mock journal data for development
        setState(() {
          resources = [
            {
              "id": 1,
              "title": "Productive Day at Work",
              "content": "Had a great day completing the project milestone. Feeling accomplished!",
              "mood": 8,
              "tags": ["work", "productivity", "achievement"],
              "createdAt": "2024-01-05T10:30:00Z"
            },
            {
              "id": 2,
              "title": "Family Dinner",
              "content": "Wonderful evening with family. The kids were so happy.",
              "mood": 9,
              "tags": ["family", "happiness", "gratitude"],
              "createdAt": "2024-01-04T19:00:00Z"
            }
          ];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _fetchJournalEntries();
  }

  void _showSearchDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: searchQuery);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.search),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Search journal entries',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                searchQuery = controller.text;
              });
              _fetchJournalEntries();
              Navigator.of(context).pop();
            },
            child: Text(localizations.search),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (localizations == null) return const SizedBox();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading && resources.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _refreshData, child: const Text('Retry')),
          ],
        ),
      );
    }

    if (resources.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              searchQuery.isEmpty
                  ? 'Search journal entries'
                  : 'No journal entries found for "$searchQuery"',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              searchQuery.isEmpty
                  ? 'Tap the search icon to get started'
                  : 'Try a different search term',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildJournalEntryCard(context, resources[index]),
          );
        },
      ),
    );
  }

  Widget _buildJournalEntryCard(BuildContext context, dynamic entry) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showJournalEntryDetail(context, entry);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.book,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry['title'] ?? 'Untitled Entry',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (entry['content'] != null)
                Text(
                  entry['content'],
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.mood,
                    color: _getMoodColor(entry['mood']),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getMoodText(entry['mood']),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: _getMoodColor(entry['mood']),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(entry['createdAt']),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showJournalEntryDetail(BuildContext context, dynamic entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(entry['title'] ?? 'Journal Entry'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.mood, color: _getMoodColor(entry['mood'])),
                  const SizedBox(width: 8),
                  Text(
                    _getMoodText(entry['mood']),
                    style: TextStyle(
                      color: _getMoodColor(entry['mood']),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Date: ${_formatDate(entry['createdAt'])}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              if (entry['content'] != null)
                Text(
                  entry['content'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  IconData _getResourceIcon(String type) {
    switch (type.toLowerCase()) {
      case 'video':
        return Icons.videocam;
      case 'audio':
        return Icons.audiotrack;
      case 'article':
      case 'file':
        return Icons.article;
      case 'image':
        return Icons.image;
      default:
        return Icons.description;
    }
  }

  Color _getMoodColor(dynamic mood) {
    if (mood == null) return Colors.grey;

    // Handle int mood values (1-10 scale)
    if (mood is int) {
      if (mood >= 8) return Colors.green; // Happy/Great
      if (mood >= 6) return Colors.lightGreen; // Good
      if (mood >= 4) return Colors.orange; // Okay
      if (mood >= 2) return Colors.red; // Bad
      return Colors.red[800]!; // Very Bad
    }

    // Handle string mood values
    final moodStr = mood.toString().toLowerCase();
    switch (moodStr) {
      case 'happy':
      case 'great':
        return Colors.green;
      case 'good':
        return Colors.lightGreen;
      case 'okay':
      case 'neutral':
        return Colors.orange;
      case 'sad':
      case 'bad':
        return Colors.red;
      case 'angry':
        return Colors.red[800]!;
      case 'anxious':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  String _getMoodText(dynamic mood) {
    if (mood == null) return 'Unknown';

    // Handle int mood values (1-10 scale)
    if (mood is int) {
      if (mood >= 9) return 'Great';
      if (mood >= 7) return 'Good';
      if (mood >= 5) return 'Okay';
      if (mood >= 3) return 'Bad';
      return 'Very Bad';
    }

    // Handle string mood values
    final moodStr = mood.toString().toLowerCase();
    switch (moodStr) {
      case 'happy':
      case 'great':
        return 'Happy';
      case 'good':
        return 'Good';
      case 'okay':
      case 'neutral':
        return 'Okay';
      case 'sad':
      case 'bad':
        return 'Sad';
      case 'angry':
        return 'Angry';
      case 'anxious':
        return 'Anxious';
      default:
        return moodStr;
    }
  }

  String _formatDate(dynamic dateValue) {
    if (dateValue == null) return 'Unknown date';

    try {
      DateTime date;

      // Handle both string and DateTime formats
      if (dateValue is String) {
        date = DateTime.parse(dateValue);
      } else if (dateValue is DateTime) {
        date = dateValue;
      } else {
        return 'Unknown date';
      }

      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return 'Unknown date';
    }
  }
}
