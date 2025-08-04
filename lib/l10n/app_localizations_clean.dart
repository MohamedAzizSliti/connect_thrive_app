import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // Common
  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get resources => _localizedValues[locale.languageCode]!['resources']!;
  String get forums => _localizedValues[locale.languageCode]!['forums']!;
  String get journal => _localizedValues[locale.languageCode]!['journal']!;
  String get doctors => _localizedValues[locale.languageCode]!['doctors']!;
  String get aiAssistant => _localizedValues[locale.languageCode]!['aiAssistant']!;
  String get settings => _localizedValues[locale.languageCode]!['settings']!;
  String get search => _localizedValues[locale.languageCode]!['search']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get save => _localizedValues[locale.languageCode]!['save']!;
  String get delete => _localizedValues[locale.languageCode]!['delete']!;
  String get edit => _localizedValues[locale.languageCode]!['edit']!;
  String get confirm => _localizedValues[locale.languageCode]!['confirm']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get refresh => _localizedValues[locale.languageCode]!['refresh']!;

  // Authentication
  String get welcomeBack => _localizedValues[locale.languageCode]!['welcomeBack']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get emailAddress => _localizedValues[locale.languageCode]!['emailAddress']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get forgotPassword => _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get signIn => _localizedValues[locale.languageCode]!['signIn']!;
  String get signUp => _localizedValues[locale.languageCode]!['signUp']!;
  String get orContinueWith => _localizedValues[locale.languageCode]!['orContinueWith']!;
  String get loginSuccess => _localizedValues[locale.languageCode]!['loginSuccess']!;
  String get loginFailed => _localizedValues[locale.languageCode]!['loginFailed']!;
  String get pleaseEnterEmail => _localizedValues[locale.languageCode]!['pleaseEnterEmail']!;
  String get pleaseEnterValidEmail => _localizedValues[locale.languageCode]!['pleaseEnterValidEmail']!;
  String get pleaseEnterPassword => _localizedValues[locale.languageCode]!['pleaseEnterPassword']!;
  String get passwordMinLength => _localizedValues[locale.languageCode]!['passwordMinLength']!;
  String get noAccountSignUp => _localizedValues[locale.languageCode]!['noAccountSignUp']!;
  String get continueAsGuest => _localizedValues[locale.languageCode]!['continueAsGuest']!;
  String get createAccount => _localizedValues[locale.languageCode]!['createAccount']!;
  String get loginSubtitle => _localizedValues[locale.languageCode]!['loginSubtitle']!;
  String get registerSubtitle => _localizedValues[locale.languageCode]!['registerSubtitle']!;
  String get confirmPassword => _localizedValues[locale.languageCode]!['confirmPassword']!;
  String get pleaseConfirmPassword => _localizedValues[locale.languageCode]!['pleaseConfirmPassword']!;
  String get passwordsDoNotMatch => _localizedValues[locale.languageCode]!['passwordsDoNotMatch']!;
  String get registrationSuccess => _localizedValues[locale.languageCode]!['registrationSuccess']!;
  String get registrationFailed => _localizedValues[locale.languageCode]!['registrationFailed']!;
  String get alreadyHaveAccountSignIn => _localizedValues[locale.languageCode]!['alreadyHaveAccountSignIn']!;

  // Journal
  String get newJournalEntry => _localizedValues[locale.languageCode]!['newJournalEntry']!;
  String get writeYourThoughts => _localizedValues[locale.languageCode]!['writeYourThoughts']!;
  String get moodToday => _localizedValues[locale.languageCode]!['moodToday']!;
  String get addPhoto => _localizedValues[locale.languageCode]!['addPhoto']!;
  String get entries => _localizedValues[locale.languageCode]!['entries']!;
  String get journalSaved => _localizedValues[locale.languageCode]!['journalSaved']!;
  String get journalUpdated => _localizedValues[locale.languageCode]!['journalUpdated']!;
  String get journalDeleted => _localizedValues[locale.languageCode]!['journalDeleted']!;
  String get confirmDeleteJournal => _localizedValues[locale.languageCode]!['confirmDeleteJournal']!;

  // Forums
  String get communityForums => _localizedValues[locale.languageCode]!['communityForums']!;
  String get allForums => _localizedValues[locale.languageCode]!['allForums']!;
  String get myForums => _localizedValues[locale.languageCode]!['myForums']!;
  String get createNewForum => _localizedValues[locale.languageCode]!['createNewForum']!;
  String get noForumsAvailable => _localizedValues[locale.languageCode]!['noForumsAvailable']!;
  String get noJoinedForums => _localizedValues[locale.languageCode]!['noJoinedForums']!;
  String get browseForums => _localizedValues[locale.languageCode]!['browseForums']!;
  String get createdBy => _localizedValues[locale.languageCode]!['createdBy']!;
  String get forumName => _localizedValues[locale.languageCode]!['forumName']!;
  String get forumDescription => _localizedValues[locale.languageCode]!['forumDescription']!;
  String get category => _localizedValues[locale.languageCode]!['category']!;
  String get participants => _localizedValues[locale.languageCode]!['participants']!;
  String get leaveForum => _localizedValues[locale.languageCode]!['leaveForum']!;

  // Home Screen
  String get goodMorning => _localizedValues[locale.languageCode]!['goodMorning']!;
  String get goodAfternoon => _localizedValues[locale.languageCode]!['goodAfternoon']!;
  String get goodEvening => _localizedValues[locale.languageCode]!['goodEvening']!;
  String get todayMood => _localizedValues[locale.languageCode]!['todayMood']!;
  String get quickActions => _localizedValues[locale.languageCode]!['quickActions']!;
  String get recentActivity => _localizedValues[locale.languageCode]!['recentActivity']!;

  // Mood & Emotions
  String get howAreYouFeeling => _localizedValues[locale.languageCode]!['howAreYouFeeling']!;
  String get happy => _localizedValues[locale.languageCode]!['happy']!;
  String get sad => _localizedValues[locale.languageCode]!['sad']!;
  String get anxious => _localizedValues[locale.languageCode]!['anxious']!;
  String get angry => _localizedValues[locale.languageCode]!['angry']!;
  String get calm => _localizedValues[locale.languageCode]!['calm']!;
  String get excited => _localizedValues[locale.languageCode]!['excited']!;
  String get stressed => _localizedValues[locale.languageCode]!['stressed']!;

  // AI Assistant
  String get askAI => _localizedValues[locale.languageCode]!['askAI']!;
  String get typeYourMessage => _localizedValues[locale.languageCode]!['typeYourMessage']!;
  String get aiIsTyping => _localizedValues[locale.languageCode]!['aiIsTyping']!;
  String get suggestions => _localizedValues[locale.languageCode]!['suggestions']!;

  // Doctors
  String get findDoctor => _localizedValues[locale.languageCode]!['findDoctor']!;
  String get bookAppointment => _localizedValues[locale.languageCode]!['bookAppointment']!;
  String get available => _localizedValues[locale.languageCode]!['available']!;
  String get notAvailable => _localizedValues[locale.languageCode]!['notAvailable']!;
  String get rating => _localizedValues[locale.languageCode]!['rating']!;
  String get reviews => _localizedValues[locale.languageCode]!['reviews']!;

  // Resources
  String get articles => _localizedValues[locale.languageCode]!['articles']!;
  String get videos => _localizedValues[locale.languageCode]!['videos']!;
  String get exercises => _localizedValues[locale.languageCode]!['exercises']!;
  String get meditation => _localizedValues[locale.languageCode]!['meditation']!;
  String get readMore => _localizedValues[locale.languageCode]!['readMore']!;
  String get watchNow => _localizedValues[locale.languageCode]!['watchNow']!;

  // Settings
  String get account => _localizedValues[locale.languageCode]!['account']!;
  String get privacy => _localizedValues[locale.languageCode]!['privacy']!;
  String get termsOfService => _localizedValues[locale.languageCode]!['termsOfService']!;
  String get helpSupport => _localizedValues[locale.languageCode]!['helpSupport']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get deleteAccount => _localizedValues[locale.languageCode]!['deleteAccount']!;

  // Theme and Design
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;
  String get lightMode => _localizedValues[locale.languageCode]!['lightMode']!;
  String get systemMode => _localizedValues[locale.languageCode]!['systemMode']!;

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Connect & Thrive',
      'home': 'Home',
      'resources': 'Resources',
      'forums': 'Forums',
      'journal': 'Journal',
      'doctors': 'Doctors',
      'aiAssistant': 'AI Assistant',
      'settings': 'Settings',
      'search': 'Search',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'confirm': 'Confirm',
      'error': 'Error',
      'retry': 'Retry',
      'refresh': 'Refresh',

      // Authentication
      'welcomeBack': 'Welcome Back',
      'login': 'Login',
      'register': 'Register',
      'emailAddress': 'Email Address',
      'password': 'Password',
      'forgotPassword': 'Forgot Password?',
      'signIn': 'Sign In',
      'signUp': 'Sign Up',
      'orContinueWith': 'Or continue with',
      'loginSuccess': 'Login successful',
      'loginFailed': 'Login failed. Please check your credentials.',
      'pleaseEnterEmail': 'Please enter your email',
      'pleaseEnterValidEmail': 'Please enter a valid email',
      'pleaseEnterPassword': 'Please enter your password',
      'passwordMinLength': 'Password must be at least 6 characters',
      'noAccountSignUp': 'Don\'t have an account? Sign up',
      'continueAsGuest': 'Continue as Guest',
      'createAccount': 'Create Account',
      'loginSubtitle': 'Welcome back! Please sign in to continue your mental health journey',
      'registerSubtitle': 'Join Connect & Thrive and start your mental health journey',
      'confirmPassword': 'Confirm Password',
      'pleaseConfirmPassword': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'registrationSuccess': 'Registration successful! Please log in.',
      'registrationFailed': 'Registration failed. Please try again.',
      'alreadyHaveAccountSignIn': 'Already have an account? Sign in',

      // Journal
      'newJournalEntry': 'New Journal Entry',
      'writeYourThoughts': 'How are you feeling today? What\'s on your mind?',
      'moodToday': 'Mood Today',
      'addPhoto': 'Add Photo',
      'entries': 'Entries',
      'journalSaved': 'Journal entry saved successfully',
      'journalUpdated': 'Journal entry updated successfully',
      'journalDeleted': 'Journal entry deleted successfully',
      'confirmDeleteJournal': 'Are you sure you want to delete this journal entry?',

      // Forums
      'communityForums': 'Community Forums',
      'allForums': 'All Forums',
      'myForums': 'My Forums',
      'createNewForum': 'Create New Forum',
      'noForumsAvailable': 'No forums available',
      'noJoinedForums': 'You haven\'t joined any forums yet',
      'browseForums': 'Browse Forums',
      'createdBy': 'Created by',
      'forumName': 'Forum Name',
      'forumDescription': 'Forum Description',
      'category': 'Category',
      'participants': 'Participants',
      'leaveForum': 'Leave Forum',

      // Home Screen
      'goodMorning': 'Good Morning',
      'goodAfternoon': 'Good Afternoon',
      'goodEvening': 'Good Evening',
      'todayMood': 'Today\'s Mood',
      'quickActions': 'Quick Actions',
      'recentActivity': 'Recent Activity',

      // Mood & Emotions
      'howAreYouFeeling': 'How are you feeling?',
      'happy': 'Happy',
      'sad': 'Sad',
      'anxious': 'Anxious',
      'angry': 'Angry',
      'calm': 'Calm',
      'excited': 'Excited',
      'stressed': 'Stressed',

      // AI Assistant
      'askAI': 'Ask AI',
      'typeYourMessage': 'Type your message...',
      'aiIsTyping': 'AI is typing...',
      'suggestions': 'Suggestions',

      // Doctors
      'findDoctor': 'Find a Doctor',
      'bookAppointment': 'Book Appointment',
      'available': 'Available',
      'notAvailable': 'Not Available',
      'rating': 'Rating',
      'reviews': 'Reviews',

      // Resources
      'articles': 'Articles',
      'videos': 'Videos',
      'exercises': 'Exercises',
      'meditation': 'Meditation',
      'readMore': 'Read More',
      'watchNow': 'Watch Now',

      // Settings
      'account': 'Account',
      'privacy': 'Privacy',
      'termsOfService': 'Terms of Service',
      'helpSupport': 'Help & Support',
      'logout': 'Logout',
      'deleteAccount': 'Delete Account',

      // Theme and Design
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'systemMode': 'System Mode',
    },
    'ar': {
      'appTitle': 'كونيكت & ثرايف',
      'home': 'الرئيسية',
      'resources': 'المصادر',
      'forums': 'المنتديات',
      'journal': 'المذكرات',
      'doctors': 'الأطباء',
      'aiAssistant': 'المساعد الذكي',
      'settings': 'الإعدادات',
      'search': 'بحث',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'delete': 'حذف',
      'edit': 'تعديل',
      'confirm': 'تأكيد',
      'error': 'خطأ',
      'retry': 'إعادة المحاولة',
      'refresh': 'تحديث',

      // Authentication
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'emailAddress': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'forgotPassword': 'نسيت كلمة المرور؟',
      'signIn': 'تسجيل الدخول',
      'signUp': 'إنشاء حساب',
      'orContinueWith': 'أو تابع باستخدام',
      'loginSuccess': 'تم تسجيل الدخول بنجاح',
      'loginFailed': 'فشل تسجيل الدخول. يرجى التحقق من بياناتك.',
      'pleaseEnterEmail': 'يرجى إدخال بريدك الإلكتروني',
      'pleaseEnterValidEmail': 'يرجى إدخال بريد إلكتروني صالح',
      'pleaseEnterPassword': 'يرجى إدخال كلمة المرور',
      'passwordMinLength': 'يجب أن تكون كلمة المرور على الأقل 6 أحرف',
      'noAccountSignUp': 'ليس لديك حساب؟ سجل الآن',
      'continueAsGuest': 'تابع كضيف',
      'createAccount': 'إنشاء حساب',
      'loginSubtitle': 'مرحباً بعودتك! يرجى تسجيل الدخول لمتابعة رحلتك في الصحة النفسية',
      'registerSubtitle': 'انضم إلى Connect & Thrive وابدأ رحلتك في الصحة النفسية',
      'confirmPassword': 'تأكيد كلمة المرور',
      'pleaseConfirmPassword': 'يرجى تأكيد كلمة المرور',
      'passwordsDoNotMatch': 'كلمات المرور غير متطابقة',
      'registrationSuccess': 'تم التسجيل بنجاح! يرجى تسجيل الدخول.',
      'registrationFailed': 'فشل التسجيل. يرجى المحاولة مرة أخرى.',
      'alreadyHaveAccountSignIn': 'هل لديك حساب بالفعل؟ سجل الدخول',

      // Journal
      'newJournalEntry': 'مذكرة جديدة',
      'writeYourThoughts': 'كيف تشعر اليوم؟ ما الذي يدور في ذهنك؟',
      'moodToday': 'المزاج اليوم',
      'addPhoto': 'إضافة صورة',
      'entries': 'المدخلات',
      'journalSaved': 'تم حفظ المذكرة بنجاح',
      'journalUpdated': 'تم تحديث المذكرة بنجاح',
      'journalDeleted': 'تم حذف المذكرة بنجاح',
      'confirmDeleteJournal': 'هل أنت متأكد أنك تريد حذف هذه المذكرة؟',

      // Forums
      'communityForums': 'منتديات المجتمع',
      'allForums': 'جميع المنتديات',
      'myForums': 'منتدياتي',
      'createNewForum': 'إنشاء منتدى جديد',
      'noForumsAvailable': 'لا توجد منتديات متاحة',
      'noJoinedForums': 'لم تنضم إلى أي منتدى بعد',
      'browseForums': 'تصفح المنتديات',
      'createdBy': 'تم الإنشاء بواسطة',
      'forumName': 'اسم المنتدى',
      'forumDescription': 'وصف المنتدى',
      'category': 'الفئة',
      'participants': 'المشاركون',
      'leaveForum': 'مغادرة المنتدى',

      // Home Screen
      'goodMorning': 'صباح الخير',
      'goodAfternoon': 'مساء الخير',
      'goodEvening': 'مساء النور',
      'todayMood': 'مزاج اليوم',
      'quickActions': 'إجراءات سريعة',
      'recentActivity': 'النشاط الأخير',

      // Mood & Emotions
      'howAreYouFeeling': 'كيف تشعر؟',
      'happy': 'سعيد',
      'sad': 'حزين',
      'anxious': 'قلق',
      'angry': 'غاضب',
      'calm': 'هادئ',
      'excited': 'متحمس',
      'stressed': 'متعب',

      // AI Assistant
      'askAI': 'اسأل الذكاء الاصطناعي',
      'typeYourMessage': 'اكتب رسالتك...',
      'aiIsTyping': 'الذكاء الاصطناعي يكتب...',
      'suggestions': 'اقتراحات',

      // Doctors
      'findDoctor': 'ابحث عن طبيب',
      'bookAppointment': 'احجز موعد',
      'available': 'متاح',
      'notAvailable': 'غير متاح',
      'rating': 'التقييم',
      'reviews': 'المراجعات',

      // Resources
      'articles': 'مقالات',
      'videos': 'فيديوهات',
      'exercises': 'تمارين',
      'meditation': 'تأمل',
      'readMore': 'اقرأ المزيد',
      'watchNow': 'شاهد الآن',

      // Settings
      'account': 'الحساب',
      'privacy': 'الخصوصية',
      'termsOfService': 'شروط الخدمة',
      'helpSupport': 'المساعدة والدعم',
      'logout': 'تسجيل الخروج',
      'deleteAccount': 'حذف الحساب',

      // Theme and Design
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
      'systemMode': 'وضع النظام',
    },
    'fr': {
      'appTitle': 'Connect & Thrive',
      'home': 'Accueil',
      'resources': 'Ressources',
      'forums': 'Forums',
      'journal': 'Journal',
      'doctors': 'Médecins',
      'aiAssistant': 'Assistant IA',
      'settings': 'Paramètres',
      'search': 'Rechercher',
      'cancel': 'Annuler',
      'save': 'Enregistrer',
      'delete': 'Supprimer',
      'edit': 'Modifier',
      'confirm': 'Confirmer',
      'error': 'Erreur',
      'retry': 'Réessayer',
      'refresh': 'Actualiser',

      // Authentication
      'login': 'Connexion',
      'register': 'S\'inscrire',
      'emailAddress': 'Adresse Email',
      'password': 'Mot de passe',
      'forgotPassword': 'Mot de passe oublié?',
      'signIn': 'Se connecter',
      'signUp': 'S\'inscrire',
      'orContinueWith': 'Ou continuer avec',
      'loginSuccess': 'Connexion réussie',
      'loginFailed': 'Échec de la connexion. Veuillez vérifier vos identifiants.',
      'pleaseEnterEmail': 'Veuillez entrer votre email',
      'pleaseEnterValidEmail': 'Veuillez entrer une adresse email valide',
      'pleaseEnterPassword': 'Veuillez entrer votre mot de passe',
      'passwordMinLength': 'Le mot de passe doit contenir au moins 6 caractères',
      'noAccountSignUp': 'Pas de compte? S\'inscrire',
      'continueAsGuest': 'Continuer en tant qu\'invité',
      'createAccount': 'Créer un compte',
      'loginSubtitle': 'Bon retour! Veuillez vous connecter pour continuer votre parcours de santé mentale',
      'registerSubtitle': 'Rejoignez Connect & Thrive et commencez votre parcours de santé mentale',
      'confirmPassword': 'Confirmer le mot de passe',
      'pleaseConfirmPassword': 'Veuillez confirmer votre mot de passe',
      'passwordsDoNotMatch': 'Les mots de passe ne correspondent pas',
      'registrationSuccess': 'Inscription réussie! Veuillez vous connecter.',
      'registrationFailed': 'Échec de l\'inscription. Veuillez réessayer.',
      'alreadyHaveAccountSignIn': 'Déjà un compte? Se connecter',

      // Journal
      'newJournalEntry': 'Nouvelle entrée de journal',
      'writeYourThoughts': 'Comment vous sentez-vous aujourd\'hui? Qu\'est-ce qui vous préoccupe?',
      'moodToday': 'Humeur du jour',
      'addPhoto': 'Ajouter une photo',
      'entries': 'Entrées',
      'journalSaved': 'Entrée de journal enregistrée avec succès',
      'journalUpdated': 'Entrée de journal mise à jour avec succès',
      'journalDeleted': 'Entrée de journal supprimée avec succès',
      'confirmDeleteJournal': 'Êtes-vous sûr de vouloir supprimer cette entrée de journal?',

      // Forums
      'communityForums': 'Forums Communautaires',
      'allForums': 'Tous les Forums',
      'myForums': 'Mes Forums',
      'createNewForum': 'Créer un Nouveau Forum',
      'noForumsAvailable': 'Aucun forum disponible',
      'noJoinedForums': 'Vous n\'avez rejoint aucun forum',
      'browseForums': 'Parcourir les Forums',
      'createdBy': 'Créé par',
      'forumName': 'Nom du Forum',
      'forumDescription': 'Description du Forum',
      'category': 'Catégorie',
      'participants': 'Participants',
      'leaveForum': 'Quitter le Forum',

      // Home Screen
      'goodMorning': 'Bonjour',
      'goodAfternoon': 'Bon Après-midi',
      'goodEvening': 'Bonsoir',
      'todayMood': 'Humeur du Jour',
      'quickActions': 'Actions Rapides',
      'recentActivity': 'Activité Récente',

      // Mood & Emotions
      'howAreYouFeeling': 'Comment vous sentez-vous?',
      'happy': 'Heureux',
      'sad': 'Triste',
      'anxious': 'Anxieux',
      'angry': 'En Colère',
      'calm': 'Calme',
      'excited': 'Excité',
      'stressed': 'Stressé',

      // AI Assistant
      'askAI': 'Demander à l\'IA',
      'typeYourMessage': 'Tapez votre message...',
      'aiIsTyping': 'L\'IA écrit...',
      'suggestions': 'Suggestions',

      // Doctors
      'findDoctor': 'Trouver un Médecin',
      'bookAppointment': 'Prendre Rendez-vous',
      'available': 'Disponible',
      'notAvailable': 'Non Disponible',
      'rating': 'Note',
      'reviews': 'Avis',

      // Resources
      'articles': 'Articles',
      'videos': 'Vidéos',
      'exercises': 'Exercices',
      'meditation': 'Méditation',
      'readMore': 'Lire Plus',
      'watchNow': 'Regarder',

      // Settings
      'account': 'Compte',
      'privacy': 'Confidentialité',
      'termsOfService': 'Conditions d\'Utilisation',
      'helpSupport': 'Aide & Support',
      'logout': 'Déconnexion',
      'deleteAccount': 'Supprimer le Compte',

      // Theme and Design
      'darkMode': 'Mode Sombre',
      'lightMode': 'Mode Clair',
      'systemMode': 'Mode Système',
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
