class JournalEntry {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final MoodData? mood;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.createdAt,
    this.updatedAt,
    this.mood,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
      mood: json['mood'] != null ? MoodData.fromJson(json['mood']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      if (mood != null) 'mood': mood!.toJson(),
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'title': title,
      'content': content,
      'tags': tags,
      if (mood != null) 'mood': mood!.toJson(),
    };
  }

  JournalEntry copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
    MoodData? mood,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      mood: mood ?? this.mood,
    );
  }
}

class MoodData {
  final int moodLevel;
  final String moodCategory;
  final String? notes;

  MoodData({required this.moodLevel, required this.moodCategory, this.notes});

  factory MoodData.fromJson(Map<String, dynamic> json) {
    return MoodData(
      moodLevel: json['mood_level'] ?? 5,
      moodCategory: json['mood_category'] ?? 'neutral',
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood_level': moodLevel,
      'mood_category': moodCategory,
      if (notes != null) 'notes': notes,
    };
  }

  MoodData copyWith({int? moodLevel, String? moodCategory, String? notes}) {
    return MoodData(
      moodLevel: moodLevel ?? this.moodLevel,
      moodCategory: moodCategory ?? this.moodCategory,
      notes: notes ?? this.notes,
    );
  }
}

class JournalSearchResult {
  final List<JournalEntry> entries;
  final int totalCount;
  final int currentPage;
  final int totalPages;

  JournalSearchResult({
    required this.entries,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
  });

  factory JournalSearchResult.fromJson(Map<String, dynamic> json) {
    return JournalSearchResult(
      entries:
          (json['entries'] as List? ?? [])
              .map((e) => JournalEntry.fromJson(e))
              .toList(),
      totalCount: json['total_count'] ?? 0,
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
