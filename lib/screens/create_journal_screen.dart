import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/journal_models.dart';
import '../services/journal_provider.dart';

class CreateJournalScreen extends StatefulWidget {
  final JournalEntry? entry;

  const CreateJournalScreen({
    super.key,
    this.entry,
  });

  @override
  State<CreateJournalScreen> createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagController = TextEditingController();
  final _moodNotesController = TextEditingController();

  List<String> _tags = [];
  bool _includeMood = false;
  int _moodLevel = 5;
  String _moodCategory = 'neutral';
  bool _isLoading = false;

  final List<String> _moodCategories = [
    'happy',
    'excited',
    'neutral',
    'sad',
    'angry',
    'anxious',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      _titleController.text = widget.entry!.title;
      _contentController.text = widget.entry!.content;
      _tags = List.from(widget.entry!.tags);
      
      if (widget.entry!.mood != null) {
        _includeMood = true;
        _moodLevel = widget.entry!.mood!.moodLevel;
        _moodCategory = widget.entry!.mood!.moodCategory;
        _moodNotesController.text = widget.entry!.mood!.notes ?? '';
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tagController.dispose();
    _moodNotesController.dispose();
    super.dispose();
  }

  Future<void> _saveJournal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final provider = context.read<JournalProvider>();
      
      MoodData? moodData;
      if (_includeMood) {
        moodData = MoodData(
          moodLevel: _moodLevel,
          moodCategory: _moodCategory,
          notes: _moodNotesController.text.trim().isEmpty 
              ? null 
              : _moodNotesController.text.trim(),
        );
      }

      bool success;
      if (widget.entry != null) {
        // Update existing entry
        final updatedEntry = widget.entry!.copyWith(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          tags: _tags,
          mood: moodData,
        );
        success = await provider.updateJournalEntry(updatedEntry);
      } else {
        // Create new entry
        success = await provider.createJournalEntry(
          title: _titleController.text.trim(),
          content: _contentController.text.trim(),
          tags: _tags,
          mood: moodData,
        );
      }

      if (success) {
        if (context.mounted) {
          Navigator.pop(context, true); // Return true to indicate success
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry != null ? 'Edit Journal' : 'Create Journal'),
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            TextButton(
              onPressed: _saveJournal,
              child: const Text('Save'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Tags',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        labelText: 'Add tag',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addTag(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addTag,
                    child: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          onDeleted: () => _removeTag(tag),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),
              SwitchListTile(
                title: const Text('Include Mood Tracking'),
                subtitle: const Text('Track your mood for this entry'),
                value: _includeMood,
                onChanged: (value) {
                  setState(() {
                    _includeMood = value;
                  });
                },
              ),
              if (_includeMood) ...[
                const SizedBox(height: 16),
                const Text(
                  'Mood Level',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _moodLevel.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label: _moodLevel.toString(),
                  onChanged: (value) {
                    setState(() {
                      _moodLevel = value.round();
                    });
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Mood Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _moodCategories.map((category) {
                    return ChoiceChip(
                      label: Text(category.capitalize()),
                      selected: _moodCategory == category,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _moodCategory = category;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _moodNotesController,
                  decoration: const InputDecoration(
                    labelText: 'Mood Notes (optional)',
                    border: OutlineInputBorder(),
                    helperText: 'Additional thoughts about your mood',
                  ),
                  maxLines: 3,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
