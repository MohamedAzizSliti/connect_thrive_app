import 'package:flutter/material.dart';
import 'package:connect_thrive_app/widgets/profile_app_bar.dart';

class MoodJournalScreen extends StatefulWidget {
  const MoodJournalScreen({super.key});

  @override
  State<MoodJournalScreen> createState() => _MoodJournalScreenState();
}

class _MoodJournalScreenState extends State<MoodJournalScreen> {
  final TextEditingController _journalController = TextEditingController();
  String? _selectedMood;
  final List<Map<String, dynamic>> _journalEntries = [
    {
      'date': 'Today',
      'mood': '😊',
      'moodLabel': 'Happy',
      'content':
          'Today was a good day. I felt more confident talking to my classmates.',
      'timestamp': '2 hours ago',
    },
    {
      'date': 'Yesterday',
      'mood': '😐',
      'moodLabel': 'Neutral',
      'content':
          'Feeling a bit stressed about upcoming exams, but trying to stay positive.',
      'timestamp': '1 day ago',
    },
  ];

  final Map<String, String> _moodEmojis = {
    'Very Happy': '😊',
    'Happy': '🙂',
    'Neutral': '😐',
    'Sad': '😔',
    'Very Sad': '😢',
    'Anxious': '😰',
    'Angry': '😠',
    'Excited': '🤗',
  };

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
        actions: [
          IconButton(icon: const Icon(Icons.bar_chart), onPressed: () {}),

          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: UserAvatar(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNewEntrySection(),
                  const SizedBox(height: 24),
                  _buildRecentEntries(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewEntrySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How are you feeling today?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Mood Selection
          const Text(
            'Select your mood',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            itemCount: _moodEmojis.length,
            itemBuilder: (context, index) {
              final mood = _moodEmojis.keys.elementAt(index);
              final emoji = _moodEmojis[mood]!;
              final isSelected = _selectedMood == mood;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMood = mood;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? const Color(0xFF6366F1).withOpacity(0.1)
                            : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isSelected
                              ? const Color(0xFF6366F1)
                              : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(emoji, style: const TextStyle(fontSize: 28)),
                      const SizedBox(height: 4),
                      Text(
                        mood,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Journal Entry
          const Text(
            'Journal Entry',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _journalController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText:
                  'What\'s on your mind? Share your thoughts and feelings...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),

          const SizedBox(height: 16),

          // Save Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveEntry,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Mood & Journal Entry',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentEntries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Entries',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalEntries.length,
          itemBuilder: (context, index) {
            final entry = _journalEntries[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildJournalEntryCard(entry),
            );
          },
        ),
      ],
    );
  }

  Widget _buildJournalEntryCard(Map<String, dynamic> entry) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry['mood'],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['date'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    entry['moodLabel'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6366F1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                entry['timestamp'],
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(entry['content'], style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text('Edit')),
              const SizedBox(width: 8),
              TextButton(onPressed: () {}, child: const Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  void _saveEntry() {
    if (_journalController.text.isNotEmpty && _selectedMood != null) {
      setState(() {
        _journalEntries.insert(0, {
          'date': 'Today',
          'mood': _moodEmojis[_selectedMood]!,
          'moodLabel': _selectedMood!,
          'content': _journalController.text,
          'timestamp': 'Just now',
        });
        _journalController.clear();
        _selectedMood = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mood and journal entry saved!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a mood and write a journal entry'),
          backgroundColor: Color(0xFFF59E0B),
        ),
      );
    }
  }
}
