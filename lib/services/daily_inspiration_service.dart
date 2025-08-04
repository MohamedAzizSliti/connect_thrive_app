import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class DailyInspiration {
  final String text;
  final String author;
  final String language;
  final String category;

  DailyInspiration({
    required this.text,
    required this.author,
    required this.language,
    required this.category,
  });
}

class DailyInspirationService {
  static const String _lastShownKey = 'last_inspiration_date';
  static const String _currentInspirationKey = 'current_inspiration';

  static final List<DailyInspiration> _arabicInspirations = [
    DailyInspiration(
      text: "الصحة النفسية ليست رفاهية، بل هي ضرورة لحياة منتجة وسعيدة.",
      author: "د. محمد الغزالي",
      language: "ar",
      category: "mental_health",
    ),
    DailyInspiration(
      text: "التوازن بين العمل والحياة هو مفتاح النجاح المستدام.",
      author: "أمينة بن عمار",
      language: "ar",
      category: "work_life_balance",
    ),
    DailyInspiration(
      text: "كل يوم جديد هو فرصة للنمو والتحسن، لا تضيعها.",
      author: "الإمام الغزالي",
      language: "ar",
      category: "personal_growth",
    ),
    DailyInspiration(
      text: "العمل الحر يمنحك الحرية، لكنه يتطلب نظاماً ذهنياً قوياً.",
      author: "سارة التريكي",
      language: "ar",
      category: "freelance",
    ),
    DailyInspiration(
      text: "العناية بنفسك ليست أنانية، بل هي أساس لرعاية الآخرين.",
      author: "د. فاطمة النفاتي",
      language: "ar",
      category: "self_care",
    ),
    DailyInspiration(
      text: "النجاح ليس فقط في الإنجازات، بل في السلام الداخلي.",
      author: "الشيخ ابن عاشور",
      language: "ar",
      category: "success",
    ),
    DailyInspiration(
      text: "الصبر والمثابرة هما مفتاحا كل إنجاز عظيم.",
      author: "الحبيب بورقيبة",
      language: "ar",
      category: "perseverance",
    ),
    DailyInspiration(
      text: "الابتسامة في وجه التحديات هي علامة القوة الحقيقية.",
      author: "ليلى بن علي",
      language: "ar",
      category: "resilience",
    ),
  ];

  static final List<DailyInspiration> _frenchInspirations = [
    DailyInspiration(
      text: "La santé mentale n'est pas un luxe, c'est une nécessité pour une vie productive et heureuse.",
      author: "Dr. Marie Dubois",
      language: "fr",
      category: "mental_health",
    ),
    DailyInspiration(
      text: "L'équilibre entre vie professionnelle et personnelle est la clé du succès durable.",
      author: "Sophie Martin",
      language: "fr",
      category: "work_life_balance",
    ),
    DailyInspiration(
      text: "Chaque jour est une nouvelle opportunité de croître et de s'améliorer.",
      author: "Victor Hugo",
      language: "fr",
      category: "personal_growth",
    ),
    DailyInspiration(
      text: "Le freelancing vous donne la liberté, mais demande une santé mentale solide.",
      author: "Jean-Pierre Lefèvre",
      language: "fr",
      category: "freelance",
    ),
    DailyInspiration(
      text: "Prendre soin de soi n'est pas égoïste, c'est la base pour prendre soin des autres.",
      author: "Dr. Claire Bernard",
      language: "fr",
      category: "self_care",
    ),
    DailyInspiration(
      text: "Le succès n'est pas seulement dans les accomplissements, mais dans la paix intérieure.",
      author: "Albert Camus",
      language: "fr",
      category: "success",
    ),
    DailyInspiration(
      text: "La patience et la persévérance sont les clés de tout accomplissement.",
      author: "Simone de Beauvoir",
      language: "fr",
      category: "perseverance",
    ),
    DailyInspiration(
      text: "Sourire face aux défis est le signe d'une vraie force.",
      author: "Édith Piaf",
      language: "fr",
      category: "resilience",
    ),
  ];

  static Future<DailyInspiration> getDailyInspiration(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';
    final lastShown = prefs.getString(_lastShownKey);

    if (lastShown != todayString) {
      // Generate new inspiration for today
      final inspiration = _generateRandomInspiration(language);
      
      await prefs.setString(_lastShownKey, todayString);
      await prefs.setString(_currentInspirationKey, '${inspiration.text}|${inspiration.author}|${inspiration.category}');
      
      return inspiration;
    } else {
      // Return cached inspiration
      final cached = prefs.getString(_currentInspirationKey);
      if (cached != null) {
        final parts = cached.split('|');
        return DailyInspiration(
          text: parts[0],
          author: parts[1],
          category: parts[2],
          language: language,
        );
      }
      
      return _generateRandomInspiration(language);
    }
  }

  static DailyInspiration _generateRandomInspiration(String language) {
    final random = Random();
    final inspirations = language == 'ar' ? _arabicInspirations : _frenchInspirations;
    return inspirations[random.nextInt(inspirations.length)];
  }

  static Future<void> forceNewInspiration(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayString = '${today.year}-${today.month}-${today.day}';
    
    final inspiration = _generateRandomInspiration(language);
    
    await prefs.setString(_lastShownKey, todayString);
    await prefs.setString(_currentInspirationKey, '${inspiration.text}|${inspiration.author}|${inspiration.category}');
  }

  static List<DailyInspiration> getAllInspirations(String language) {
    return language == 'ar' ? _arabicInspirations : _frenchInspirations;
  }
}
