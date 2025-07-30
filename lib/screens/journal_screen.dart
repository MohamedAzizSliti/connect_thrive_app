import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _journalController = TextEditingController();
  final List<Map<String, dynamic>> _journalEntries = [
    {
      'date': 'Today',
      'content':
          'Today was a good day. I felt more confident talking to my classmates.',
      'mood': '😊',
    },
    {
      'date': 'Yesterday',
      'content':
          'Feeling a bit stressed about upcoming exams, but trying to stay positive.',
      'mood': '😐',
    },
  ];

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
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
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
            'New Journal Entry',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _journalController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'How are you feeling today? What\'s on your mind?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.mood, color: Color(0xFF6366F1)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.photo_camera,
                      color: Color(0xFF6366F1),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _saveEntry,
                child: const Text('Save Entry'),
              ),
            ],
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
              Text(
                entry['date'],
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
              const Spacer(),
              Text(entry['mood'], style: const TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 8),
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
    if (_journalController.text.isNotEmpty) {
      setState(() {
        _journalEntries.insert(0, {
          'date': 'Today',
          'content': _journalController.text,
          'mood': '😐',
        });
        _journalController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Journal entry saved'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }
  }
}
