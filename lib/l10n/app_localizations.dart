import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get resources => _localizedValues[locale.languageCode]!['resources']!;
  String get forums => _localizedValues[locale.languageCode]!['forums']!;
  String get journal => _localizedValues[locale.languageCode]!['journal']!;
  String get doctors => _localizedValues[locale.languageCode]!['doctors']!;
  String get aiAssistant => _localizedValues[locale.languageCode]!['aiAssistant']!;
  String get dailyInspiration => _localizedValues[locale.languageCode]!['dailyInspiration']!;
  String get mentalHealth => _localizedValues[locale.languageCode]!['mentalHealth']!;
  String get community => _localizedValues[locale.languageCode]!['community']!;
  String get newForum => _localizedValues[locale.languageCode]!['newForum']!;
  String get createForum => _localizedValues[locale.languageCode]!['createForum']!;
  String get joinForum => _localizedValues[locale.languageCode]!['joinForum']!;
  String get viewForum => _localizedValues[locale.languageCode]!['viewForum']!;
  String get members => _localizedValues[locale.languageCode]!['members']!;
  String get posts => _localizedValues[locale.languageCode]!['posts']!;
  String get newJournalEntry => _localizedValues[locale.languageCode]!['newJournalEntry']!;
  String get moodTracker => _localizedValues[locale.languageCode]!['moodTracker']!;
  String get weeklyOverview => _localizedValues[locale.languageCode]!['weeklyOverview']!;
  String get entries => _localizedValues[locale.languageCode]!['entries']!;
  String get averageMood => _localizedValues[locale.languageCode]!['averageMood']!;
  String get streak => _localizedValues[locale.languageCode]!['streak']!;
  String get tunisianDoctors => _localizedValues[locale.languageCode]!['tunisianDoctors']!;
  String get location => _localizedValues[locale.languageCode]!['location']!;
  String get specialty => _localizedValues[locale.languageCode]!['specialty']!;
  String get call => _localizedValues[locale.languageCode]!['call']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get freelance => _localizedValues[locale.languageCode]!['freelance']!;
  String get workLifeBalance => _localizedValues[locale.languageCode]!['workLifeBalance']!;
  String get mentalWellness => _localizedValues[locale.languageCode]!['mentalWellness']!;
  String get productivity => _localizedValues[locale.languageCode]!['productivity']!;

  static final Map<String, Map<String, String>> _localizedValues = {
    'ar': {
      'appTitle': 'Connect & Thrive',
      'home': 'الرئيسية',
      'resources': 'الموارد',
      'forums': 'المنتديات',
      'journal': 'المذكرات',
      'doctors': 'الأطباء',
      'aiAssistant': 'المساعد الذكي',
      'dailyInspiration': 'الإلهام اليومي',
      'mentalHealth': 'الصحة النفسية',
      'community': 'المجتمع',
      'newForum': 'منتدى جديد',
      'createForum': 'إنشاء منتدى',
      'joinForum': 'انضمام',
      'viewForum': 'عرض',
      'members': 'الأعضاء',
      'posts': 'المشاركات',
      'newJournalEntry': 'مذكرة جديدة',
      'moodTracker': 'تتبع المزاج',
      'weeklyOverview': 'نظرة عامة أسبوعية',
      'entries': 'المذكرات',
      'averageMood': 'متوسط المزاج',
      'streak': 'السلسلة',
      'tunisianDoctors': 'أطباء تونسيين',
      'location': 'الموقع',
      'specialty': 'التخصص',
      'call': 'اتصال',
      'email': 'بريد إلكتروني',
      'freelance': 'العمل الحر',
      'workLifeBalance': 'التوازن بين العمل والحياة',
      'mentalWellness': 'الرفاهية النفسية',
      'productivity': 'الإنتاجية',
    },
    'fr': {
      'appTitle': 'Connect & Thrive',
      'home': 'Accueil',
      'resources': 'Ressources',
      'forums': 'Forums',
      'journal': 'Journal',
      'doctors': 'Médecins',
      'aiAssistant': 'Assistant IA',
      'dailyInspiration': 'Inspiration Quotidienne',
      'mentalHealth': 'Santé Mentale',
      'community': 'Communauté',
      'newForum': 'Nouveau Forum',
      'createForum': 'Créer un Forum',
      'joinForum': 'Rejoindre',
      'viewForum': 'Voir',
      'members': 'Membres',
      'posts': 'Publications',
      'newJournalEntry': 'Nouvelle Entrée',
      'moodTracker': 'Suivi de l\'Humeur',
      'weeklyOverview': 'Aperçu Hebdomadaire',
      'entries': 'Entrées',
      'averageMood': 'Humeur Moyenne',
      'streak': 'Série',
      'tunisianDoctors': 'Médecins Tunisiens',
      'location': 'Emplacement',
      'specialty': 'Spécialité',
      'call': 'Appeler',
      'email': 'Email',
      'freelance': 'Freelance',
      'workLifeBalance': 'Équilibre Vie Pro',
      'mentalWellness': 'Bien-être Mental',
      'productivity': 'Productivité',
    },
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
