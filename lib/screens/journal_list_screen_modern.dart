import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/journal_models.dart';
import '../services/journal_provider.dart';
import 'create_journal_screen.dart';
import 'journal_detail_screen.dart';

class JournalListScreen extends StatefulWidget {
  const JournalListScreen({super.key});

  @override
  State<JournalListScreen> createState() => _JournalListScreenState();
}

class _JournalListScreenState extends State<JournalListScreen> {
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JournalProvider>().loadJournalEntries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Defer loading until after the build is complete to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<JournalProvider>().loadJournalEntries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Journal & Mood Tracker',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      body: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          if (journalProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          final entries = journalProvider.journalEntries.where((entry) {
            return _searchQuery.isEmpty ||
                entry.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                entry.content.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();

          if (entries.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: journalProvider.loadJournalEntries,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: _buildMoodSummaryCard(entries),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildModernJournalCard(entries[index]);
                      },
                      childCount: entries.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final journalProvider = context.read<JournalProvider>();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateJournalScreen()),
          );
          if (result == true) {
            await journalProvider.loadJournalEntries();
          }
        },
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Entry'),
      ),
    );
  }

  Widget _buildMoodSummaryCard(List<JournalEntry> entries) {
    final recentEntries = entries.take(7).toList();
    final moodData = _calculateMoodStats(recentEntries);
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weekly Mood Overview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMoodStat('Entries', entries.length.toString(), Colors.blue),
              _buildMoodStat('Avg Mood', moodData['average']?.toStringAsFixed(1) ?? 'N/A', Colors.green),
              _buildMoodStat('Streak', moodData['streak']?.toString() ?? '0', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildModernJournalCard(JournalEntry entry) {
    final moodColor = _getMoodColor(entry.mood?.moodCategory ?? 'Neutral');
    final moodIcon = _getMoodIcon(entry.mood?.moodCategory ?? 'Neutral');
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JournalDetailScreen(entry: entry),
              ),
            );
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
                        color: moodColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        moodIcon,
                        color: moodColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.title,
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
                            _formatDate(entry.createdAt),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (entry.mood != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: moodColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              moodIcon,
                              color: moodColor,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${entry.mood!.moodLevel}/10',
                              style: TextStyle(
                                color: moodColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  entry.content,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (entry.mood != null && entry.mood!.notes != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '📝 ${entry.mood!.notes}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 20),
          Text(
            'No journal entries yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start tracking your mood and thoughts',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final journalProvider = context.read<JournalProvider>();
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateJournalScreen()),
              );
              if (result == true) {
                await journalProvider.loadJournalEntries();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Create First Entry'),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateMoodStats(List<JournalEntry> entries) {
    if (entries.isEmpty) {
      return {'average': 0.0, 'streak': 0};
    }

    final moodEntries = entries.where((e) => e.mood != null).toList();
    if (moodEntries.isEmpty) {
      return {'average': 0.0, 'streak': 0};
    }

    final totalMood = moodEntries.fold(0, (sum, entry) => sum + (entry.mood?.moodLevel ?? 0));
    final average = totalMood / moodEntries.length;

    int streak = 0;
    DateTime? lastDate;
    for (var entry in entries) {
      if (lastDate == null || entry.createdAt.difference(lastDate).inDays <= 1) {
        streak++;
        lastDate = entry.createdAt;
      } else {
        break;
      }
    }

    return {'average': average, 'streak': streak};
  }

  String _formatDate(DateTime date) {
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
  }

  Color _getMoodColor(String moodCategory) {
    switch (moodCategory.toLowerCase()) {
      case 'happy':
        return Colors.green;
      case 'sad':
        return Colors.blue;
      case 'angry':
        return Colors.red;
      case 'anxious':
        return Colors.orange;
      case 'excited':
        return Colors.purple;
      case 'calm':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  IconData _getMoodIcon(String moodCategory) {
    switch (moodCategory.toLowerCase()) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'sad':
        return Icons.sentiment_dissatisfied;
      case 'angry':
        return Icons.sentiment_very_dissatisfied;
      case 'anxious':
        return Icons.sentiment_neutral;
      case 'excited':
        return Icons.sentiment_satisfied_alt;
      case 'calm':
        return Icons.sentiment_satisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: _searchQuery);
        return AlertDialog(
          title: const Text('Search Journal Entries'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Search by title or content...',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
