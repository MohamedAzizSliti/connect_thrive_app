import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../l10n/app_localizations.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _journalController = TextEditingController();
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  
  final List<Map<String, dynamic>> _journalEntries = [
    {
      'date': 'Today',
      'content': 'Today was a good day. I felt more confident talking to my classmates.',
      'mood': '😊',
      'timestamp': DateTime.now(),
      'color': Colors.blue,
    },
    {
      'date': 'Yesterday',
      'content': 'Feeling a bit stressed about upcoming exams, but trying to stay positive.',
      'mood': '😐',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'color': Colors.orange,
    },
    {
      'date': '2 days ago',
      'content': 'Had a great conversation with my friend. Feeling understood and supported.',
      'mood': '😄',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'color': Colors.green,
    },
  ];

  final List<Map<String, dynamic>> _moodOptions = [
    {'emoji': '😊', 'label': 'Happy', 'color': Colors.yellow},
    {'emoji': '😢', 'label': 'Sad', 'color': Colors.blue},
    {'emoji': '😡', 'label': 'Angry', 'color': Colors.red},
    {'emoji': '😰', 'label': 'Anxious', 'color': Colors.purple},
    {'emoji': '😐', 'label': 'Neutral', 'color': Colors.grey},
    {'emoji': '😴', 'label': 'Tired', 'color': Colors.indigo},
    {'emoji': '🥰', 'label': 'Loved', 'color': Colors.pink},
    {'emoji': '🤗', 'label': 'Excited', 'color': Colors.orange},
  ];

  String _selectedMood = '😐';
  Color _selectedColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _journalController.dispose();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          localizations.journal,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.calendar_today, size: 20),
              onPressed: () {},
              tooltip: localizations.date,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildMoodTracker()),
              SliverToBoxAdapter(child: _buildNewEntrySection()),
              SliverToBoxAdapter(child: _buildRecentEntries()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntryDialog(context),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: Text(localizations.newJournalEntry),
        elevation: 4,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.journal,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your thoughts and emotions',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodTracker() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mood Tracker',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _moodOptions.map((mood) {
              return ChoiceChip(
                label: Text(mood['label']),
                selected: _selectedMood == mood['emoji'],
                onSelected: (selected) {
                  setState(() {
                    _selectedMood = selected ? mood['emoji'] : '😐';
                    _selectedColor = selected ? mood['color'] : Colors.grey;
                  });
                },
                selectedColor: Theme.of(context).colorScheme.primary,
                labelStyle: TextStyle(color: _selectedMood == mood['emoji'] ? Colors.white : Theme.of(context).colorScheme.onSurface),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewEntrySection() {
    final localizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.newJournalEntry,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _journalController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: localizations.writeYourThoughts,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.all(16),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.mood, color: Theme.of(context).colorScheme.primary),
                    onPressed: () {},
                    tooltip: localizations.moodToday,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.photo_camera,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {},
                    tooltip: localizations.addPhoto,
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _saveEntry,
                icon: const Icon(Icons.save, size: 18),
                label: Text(localizations.save),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentEntries() {
    final localizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.entries,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
    final localizations = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(entry['mood'], style: const TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            entry['content'],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 16),
                label: Text(localizations.edit),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete, size: 16),
                label: Text(localizations.delete),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
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
          'mood': _selectedMood,
          'timestamp': DateTime.now(),
          'color': _selectedColor,
        });
        _journalController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.journalSaved),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  void _showAddEntryDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                localizations.newJournalEntry,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _journalController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: localizations.writeYourThoughts,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _moodOptions.map((mood) {
                  return ChoiceChip(
                    label: Text('${mood['emoji']} ${mood['label']}'),
                    selected: _selectedMood == mood['emoji'],
                    onSelected: (selected) {
                      setState(() {
                        _selectedMood = selected ? mood['emoji'] : '😐';
                        _selectedColor = selected ? mood['color'] : Colors.grey;
                      });
                    },
                    selectedColor: mood['color'].withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: _selectedMood == mood['emoji'] 
                          ? mood['color'] 
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(localizations.cancel),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _saveEntry();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                    label: Text(localizations.save),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
