import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedMood;
  final TextEditingController _notesController = TextEditingController();
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _moodOptions = [
    {
      'emoji': '😊',
      'label': 'Happy',
      'color': Colors.amber,
      'gradient': [Colors.amber, Colors.orange],
    },
    {
      'emoji': '😄',
      'label': 'Excited',
      'color': Colors.orange,
      'gradient': [Colors.orange, Colors.deepOrange],
    },
    {
      'emoji': '🥰',
      'label': 'Loved',
      'color': Colors.pink,
      'gradient': [Colors.pink, Colors.pinkAccent],
    },
    {
      'emoji': '😐',
      'label': 'Neutral',
      'color': Colors.blueGrey,
      'gradient': [Colors.blueGrey, Colors.grey],
    },
    {
      'emoji': '😔',
      'label': 'Sad',
      'color': Colors.blue,
      'gradient': [Colors.blue, Colors.indigo],
    },
    {
      'emoji': '😢',
      'label': 'Very Sad',
      'color': Colors.indigo,
      'gradient': [Colors.indigo, Colors.deepPurple],
    },
    {
      'emoji': '😰',
      'label': 'Anxious',
      'color': Colors.purple,
      'gradient': [Colors.purple, Colors.deepPurple],
    },
    {
      'emoji': '😠',
      'label': 'Angry',
      'color': Colors.red,
      'gradient': [Colors.red, Colors.deepOrange],
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _recentMoods = [
    {
      'date': 'Yesterday',
      'emoji': '😊',
      'mood': 'Happy',
      'notes': 'Had a great day with friends',
    },
    {
      'date': '2 days ago',
      'emoji': '😐',
      'mood': 'Neutral',
      'notes': 'Feeling okay, nothing special',
    },
    {
      'date': '3 days ago',
      'emoji': '😔',
      'mood': 'Sad',
      'notes': 'Missing family and feeling lonely',
    },
    {
      'date': '4 days ago',
      'emoji': '😄',
      'mood': 'Excited',
      'notes': 'Looking forward to the weekend!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Mood Tracker'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              icon: const Icon(Icons.bar_chart_rounded, size: 20),
              onPressed: () {},
              tooltip: 'Statistics',
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
              SliverToBoxAdapter(child: _buildTodayMood()),
              SliverToBoxAdapter(child: _buildMoodSelector()),
              SliverToBoxAdapter(child: _buildNotesSection()),
              SliverToBoxAdapter(child: _buildRecentMoods()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _selectedMood != null ? _saveMood : null,
        backgroundColor: _selectedMood != null
            ? _moodOptions.firstWhere(
                (mood) => mood['label'] == _selectedMood,
              )['color']
            : Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.save_rounded),
        label: Text('Save Mood'),
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
            'Mood Tracker',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your emotions and understand patterns',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayMood() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _selectedMood != null
              ? _moodOptions.firstWhere(
                  (mood) => mood['label'] == _selectedMood,
                )['gradient']
              : [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                (_selectedMood != null
                        ? _moodOptions.firstWhere(
                            (mood) => mood['label'] == _selectedMood,
                          )['color']
                        : Theme.of(context).colorScheme.primary)
                    .withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _selectedMood != null ? 'You are feeling' : 'How are you feeling?',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedMood != null
                ? 'Tap to change your mood'
                : 'Select your current mood below',
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          if (_selectedMood != null)
            Column(
              children: [
                Text(
                  _moodOptions.firstWhere(
                    (mood) => mood['label'] == _selectedMood,
                  )['emoji'],
                  style: const TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedMood!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose your mood',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: _moodOptions.length,
            itemBuilder: (context, index) {
              final mood = _moodOptions[index];
              final isSelected = _selectedMood == mood['label'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedMood = mood['label'];
                  });
                  _animationController.forward(from: 0);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: mood['gradient'],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? mood['color'].withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                        blurRadius: isSelected ? 15 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        mood['emoji'],
                        style: TextStyle(
                          fontSize: isSelected ? 36 : 32,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mood['label'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add your thoughts',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind? Share your thoughts...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentMoods() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Moods',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ..._recentMoods
              .map(
                (mood) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildMoodHistoryItem(
                    mood['date']!,
                    mood['emoji']!,
                    mood['mood']!,
                    mood['notes']!,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildMoodHistoryItem(
    String date,
    String emoji,
    String mood,
    String notes,
  ) {
    final moodColor = _moodOptions.firstWhere(
      (m) => m['label'] == mood,
      orElse: () => {'color': Colors.grey},
    )['color'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: moodColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  mood,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: moodColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notes,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Theme.of(
              context,
            ).colorScheme.onSurfaceVariant.withOpacity(0.5),
            size: 20,
          ),
        ],
      ),
    );
  }

  void _saveMood() {
    if (_selectedMood != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mood saved: $_selectedMood'),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
      setState(() {
        _selectedMood = null;
        _notesController.clear();
      });
    }
  }
}
