import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/journal_models.dart';

class AIService {
  static const String _apiKey =
      'AIzaSyC3LJEZgpSCm9tXSAiRpRw9A9umwy3Jcxk'; // Replace with your actual API key
  static late final GenerativeModel _model;
  static late final ChatSession _chatSession;

  static void initialize() {
    _model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: _apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
    );
    _chatSession = _model.startChat();
  }

  static Future<String> getPsychiatristAdvice({
    required String userMessage,
    List<JournalEntry>? recentEntries,
    MoodData? currentMood,
  }) async {
    try {
      if (_apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        return 'AI features are currently in development. Please add your Gemini API key to enable this feature.';
      }

      final context = _buildContext(recentEntries, currentMood);
      final prompt = '''
You are an AI mental health assistant designed to provide supportive guidance and general wellness advice. 

IMPORTANT DISCLAIMERS:
- You are NOT a licensed psychiatrist or medical professional
- You cannot provide medical diagnoses or treatment
- For serious mental health concerns, users should consult licensed professionals
- Your role is to provide general support, coping strategies, and wellness suggestions

Based on the user's message and their recent journal entries, provide empathetic, supportive, and practical advice. Focus on:
- Emotional validation and support
- General wellness strategies
- Coping techniques
- Mindfulness suggestions
- Encouraging professional help when appropriate

User Context: $context

User Message: $userMessage

Please provide a supportive and helpful response:
      ''';

      final response = await _chatSession.sendMessage(Content.text(prompt));
      return response.text ??
          'I apologize, but I couldn\'t generate a response at this time.';
    } catch (e) {
      return 'I\'m having trouble connecting to the AI service. Please try again later.';
    }
  }

  static Future<String> analyzeMoodTrend(List<JournalEntry> entries) async {
    try {
      if (_apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        return 'AI mood analysis is currently in development. Please add your Gemini API key to enable this feature.';
      }

      final moodData = _extractMoodData(entries);
      final prompt = '''
Analyze the following mood patterns from journal entries and provide gentle insights and suggestions:

$moodData

Please provide:
1. Overall mood trend summary
2. Gentle observations about patterns
3. Supportive suggestions for emotional wellness
4. Encouraging next steps

Keep the tone supportive and non-clinical. Focus on general wellness rather than diagnosis.
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to analyze mood patterns at this time.';
    } catch (e) {
      return 'Unable to analyze mood data currently. Please try again later.';
    }
  }

  static Future<String> suggestCopingStrategies({
    required String moodCategory,
    required int moodLevel,
  }) async {
    try {
      if (_apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        return 'AI coping strategies are currently in development. Please add your Gemini API key to enable this feature.';
      }

      final prompt = '''
Provide gentle, supportive coping strategies for someone experiencing $moodCategory feelings at level $moodLevel out of 10.

Focus on:
- Immediate self-care suggestions
- Simple grounding techniques
- Mindfulness exercises
- When to seek additional support
- Encouraging and validating language

Remember: You are providing general wellness support, not medical advice.
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ??
          'Unable to provide coping strategies at this time.';
    } catch (e) {
      return 'Unable to provide coping strategies currently. Please try again later.';
    }
  }

  static String _buildContext(
    List<JournalEntry>? entries,
    MoodData? currentMood,
  ) {
    final buffer = StringBuffer();

    if (currentMood != null) {
      buffer.writeln(
        'Current mood: ${currentMood.moodCategory} (level ${currentMood.moodLevel}/10)',
      );
      if (currentMood.notes != null) {
        buffer.writeln('Mood notes: ${currentMood.notes}');
      }
    }

    if (entries != null && entries.isNotEmpty) {
      buffer.writeln('\nRecent journal entries:');
      final recent = entries.take(3).toList();
      for (var entry in recent) {
        buffer.writeln(
          '- ${entry.title}: ${entry.content.substring(0, entry.content.length.clamp(0, 100))}...',
        );
        if (entry.mood != null) {
          buffer.writeln(
            '  Mood: ${entry.mood!.moodCategory} (${entry.mood!.moodLevel}/10)',
          );
        }
      }
    }

    return buffer.toString();
  }

  static String _extractMoodData(List<JournalEntry> entries) {
    final moodEntries = entries.where((e) => e.mood != null).toList();
    if (moodEntries.isEmpty) return 'No mood data available';

    final buffer = StringBuffer();
    for (var entry in moodEntries.take(10)) {
      buffer.writeln(
        '${entry.createdAt.toString().substring(0, 10)}: ${entry.mood!.moodCategory} (${entry.mood!.moodLevel}/10) - ${entry.title}',
      );
    }
    return buffer.toString();
  }

  static void dispose() {
    // Clean up resources if needed
  }
}
