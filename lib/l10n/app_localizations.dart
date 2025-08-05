import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Common
  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get resources => _localizedValues[locale.languageCode]!['resources']!;
  String get forums => _localizedValues[locale.languageCode]!['forums']!;
  String get journal => _localizedValues[locale.languageCode]!['journal']!;
  String get doctors => _localizedValues[locale.languageCode]!['doctors']!;
  String get aiAssistant =>
      _localizedValues[locale.languageCode]!['aiAssistant']!;
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
  String get date => _localizedValues[locale.languageCode]!['date']!;

  // Authentication
  String get welcomeBack =>
      _localizedValues[locale.languageCode]!['welcomeBack']!;

  // Onboarding
  String get onboardingWelcomeTitle =>
      _localizedValues[locale.languageCode]!['onboardingWelcomeTitle']!;
  String get onboardingWelcomeDesc =>
      _localizedValues[locale.languageCode]!['onboardingWelcomeDesc']!;
  String get onboardingMoodTitle =>
      _localizedValues[locale.languageCode]!['onboardingMoodTitle']!;
  String get onboardingMoodDesc =>
      _localizedValues[locale.languageCode]!['onboardingMoodDesc']!;
  String get onboardingCommunityTitle =>
      _localizedValues[locale.languageCode]!['onboardingCommunityTitle']!;
  String get onboardingCommunityDesc =>
      _localizedValues[locale.languageCode]!['onboardingCommunityDesc']!;
  String get skip => _localizedValues[locale.languageCode]!['skip']!;

  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get loginSubtitle =>
      _localizedValues[locale.languageCode]!['loginSubtitle']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get emailAddress =>
      _localizedValues[locale.languageCode]!['emailAddress']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get forgotPassword =>
      _localizedValues[locale.languageCode]!['forgotPassword']!;
  String get signIn => _localizedValues[locale.languageCode]!['signIn']!;
  String get signUp => _localizedValues[locale.languageCode]!['signUp']!;
  String get orContinueWith =>
      _localizedValues[locale.languageCode]!['orContinueWith']!;
  String get loginSuccess =>
      _localizedValues[locale.languageCode]!['loginSuccess']!;
  String get loginFailed =>
      _localizedValues[locale.languageCode]!['loginFailed']!;
  String get pleaseEnterEmail =>
      _localizedValues[locale.languageCode]!['pleaseEnterEmail']!;
  String get pleaseEnterValidEmail =>
      _localizedValues[locale.languageCode]!['pleaseEnterValidEmail']!;
  String get pleaseEnterPassword =>
      _localizedValues[locale.languageCode]!['pleaseEnterPassword']!;
  String get passwordMinLength =>
      _localizedValues[locale.languageCode]!['passwordMinLength']!;
  String get noAccountSignUp =>
      _localizedValues[locale.languageCode]!['noAccountSignUp']!;
  String get continueAsGuest =>
      _localizedValues[locale.languageCode]!['continueAsGuest']!;
  String get createAccount =>
      _localizedValues[locale.languageCode]!['createAccount']!;
  String get registerSubtitle =>
      _localizedValues[locale.languageCode]!['registerSubtitle']!;
  String get confirmPassword =>
      _localizedValues[locale.languageCode]!['confirmPassword']!;
  String get pleaseConfirmPassword =>
      _localizedValues[locale.languageCode]!['pleaseConfirmPassword']!;
  String get passwordsDoNotMatch =>
      _localizedValues[locale.languageCode]!['passwordsDoNotMatch']!;
  String get registrationSuccess =>
      _localizedValues[locale.languageCode]!['registrationSuccess']!;
  String get registrationFailed =>
      _localizedValues[locale.languageCode]!['registrationFailed']!;
  String get alreadyHaveAccountSignIn =>
      _localizedValues[locale.languageCode]!['alreadyHaveAccountSignIn']!;

  // Modern Login Screen
  String get signInToContinue =>
      _localizedValues[locale.languageCode]!['signInToContinue']!;
  String get poweredBy => _localizedValues[locale.languageCode]!['poweredBy']!;
  String get ministryOfYouthAndSports =>
      _localizedValues[locale.languageCode]!['ministryOfYouthAndSports']!;
  String get connectAndThrive =>
      _localizedValues[locale.languageCode]!['connectAndThrive']!;

  // Journal
  String get newJournalEntry =>
      _localizedValues[locale.languageCode]!['newJournalEntry']!;
  String get writeYourThoughts =>
      _localizedValues[locale.languageCode]!['writeYourThoughts']!;
  String get moodToday => _localizedValues[locale.languageCode]!['moodToday']!;
  String get addPhoto => _localizedValues[locale.languageCode]!['addPhoto']!;
  String get entries => _localizedValues[locale.languageCode]!['entries']!;
  String get journalSaved =>
      _localizedValues[locale.languageCode]!['journalSaved']!;
  String get journalUpdated =>
      _localizedValues[locale.languageCode]!['journalUpdated']!;
  String get journalDeleted =>
      _localizedValues[locale.languageCode]!['journalDeleted']!;
  String get confirmDeleteJournal =>
      _localizedValues[locale.languageCode]!['confirmDeleteJournal']!;

  // Forums
  String get communityForums =>
      _localizedValues[locale.languageCode]!['communityForums']!;
  String get allForums => _localizedValues[locale.languageCode]!['allForums']!;
  String get myForums => _localizedValues[locale.languageCode]!['myForums']!;
  String get createNewForum =>
      _localizedValues[locale.languageCode]!['createNewForum']!;
  String get noForumsAvailable =>
      _localizedValues[locale.languageCode]!['noForumsAvailable']!;
  String get noJoinedForums =>
      _localizedValues[locale.languageCode]!['noJoinedForums']!;
  String get browseForums =>
      _localizedValues[locale.languageCode]!['browseForums']!;
  String get createdBy => _localizedValues[locale.languageCode]!['createdBy']!;
  String get forumName => _localizedValues[locale.languageCode]!['forumName']!;
  String get forumDescription =>
      _localizedValues[locale.languageCode]!['forumDescription']!;
  String get category => _localizedValues[locale.languageCode]!['category']!;
  String get participants =>
      _localizedValues[locale.languageCode]!['participants']!;
  String get leaveForum =>
      _localizedValues[locale.languageCode]!['leaveForum']!;

  // Home Screen
  String get goodMorning =>
      _localizedValues[locale.languageCode]!['goodMorning']!;
  String get goodAfternoon =>
      _localizedValues[locale.languageCode]!['goodAfternoon']!;
  String get goodEvening =>
      _localizedValues[locale.languageCode]!['goodEvening']!;
  String get todayMood => _localizedValues[locale.languageCode]!['todayMood']!;
  String get quickActions =>
      _localizedValues[locale.languageCode]!['quickActions']!;
  String get recentActivity =>
      _localizedValues[locale.languageCode]!['recentActivity']!;

  // Mood & Emotions
  String get howAreYouFeeling =>
      _localizedValues[locale.languageCode]!['howAreYouFeeling']!;
  String get happy => _localizedValues[locale.languageCode]!['happy']!;
  String get sad => _localizedValues[locale.languageCode]!['sad']!;
  String get anxious => _localizedValues[locale.languageCode]!['anxious']!;
  String get angry => _localizedValues[locale.languageCode]!['angry']!;
  String get calm => _localizedValues[locale.languageCode]!['calm']!;
  String get excited => _localizedValues[locale.languageCode]!['excited']!;
  String get stressed => _localizedValues[locale.languageCode]!['stressed']!;

  // AI Assistant
  String get askAI => _localizedValues[locale.languageCode]!['askAI']!;
  String get typeYourMessage =>
      _localizedValues[locale.languageCode]!['typeYourMessage']!;
  String get aiIsTyping =>
      _localizedValues[locale.languageCode]!['aiIsTyping']!;
  String get suggestions =>
      _localizedValues[locale.languageCode]!['suggestions']!;
  String get aiAssistantTitle =>
      _localizedValues[locale.languageCode]!['aiAssistantTitle']!;
  String get aiWelcomeMessage =>
      _localizedValues[locale.languageCode]!['aiWelcomeMessage']!;
  String get aiDisclaimerTitle =>
      _localizedValues[locale.languageCode]!['aiDisclaimerTitle']!;
  String get aiDisclaimerText =>
      _localizedValues[locale.languageCode]!['aiDisclaimerText']!;
  String get aiHowCanIHelp =>
      _localizedValues[locale.languageCode]!['aiHowCanIHelp']!;
  String get aiDisclaimerBanner =>
      _localizedValues[locale.languageCode]!['aiDisclaimerBanner']!;
  String get aiInputHint =>
      _localizedValues[locale.languageCode]!['aiInputHint']!;
  String get aiErrorMessage =>
      _localizedValues[locale.languageCode]!['aiErrorMessage']!;

  // Forums

  String get newForum => _localizedValues[locale.languageCode]!['newForum']!;
  String get members => _localizedValues[locale.languageCode]!['members']!;
  String get posts => _localizedValues[locale.languageCode]!['posts']!;
  String get viewForum => _localizedValues[locale.languageCode]!['viewForum']!;
  String get joinForum => _localizedValues[locale.languageCode]!['joinForum']!;
  String get noForumsJoinedYet =>
      _localizedValues[locale.languageCode]!['noForumsJoinedYet']!;
  String get joinSomeForumsToSeeThem =>
      _localizedValues[locale.languageCode]!['joinSomeForumsToSeeThem']!;
  String get beTheFirstToCreateForum =>
      _localizedValues[locale.languageCode]!['beTheFirstToCreateForum']!;
  String get createFirstForum =>
      _localizedValues[locale.languageCode]!['createFirstForum']!;

  // Doctors
  String get findDoctor =>
      _localizedValues[locale.languageCode]!['findDoctor']!;
  String get bookAppointment =>
      _localizedValues[locale.languageCode]!['bookAppointment']!;
  String get available => _localizedValues[locale.languageCode]!['available']!;
  String get notAvailable =>
      _localizedValues[locale.languageCode]!['notAvailable']!;
  String get rating => _localizedValues[locale.languageCode]!['rating']!;
  String get reviews => _localizedValues[locale.languageCode]!['reviews']!;
  String get searchDoctorsHint =>
      _localizedValues[locale.languageCode]!['searchDoctorsHint']!;
  String get location => _localizedValues[locale.languageCode]!['location']!;
  String get specialty => _localizedValues[locale.languageCode]!['specialty']!;
  String get all => _localizedValues[locale.languageCode]!['all']!;
  String get contact => _localizedValues[locale.languageCode]!['contact']!;
  String get voluntaryService =>
      _localizedValues[locale.languageCode]!['voluntaryService']!;

  // Resources
  String get articles => _localizedValues[locale.languageCode]!['articles']!;
  String get videos => _localizedValues[locale.languageCode]!['videos']!;
  String get exercises => _localizedValues[locale.languageCode]!['exercises']!;
  String get meditation =>
      _localizedValues[locale.languageCode]!['meditation']!;
  String get readMore => _localizedValues[locale.languageCode]!['readMore']!;
  String get watchNow => _localizedValues[locale.languageCode]!['watchNow']!;

  // Settings
  String get account => _localizedValues[locale.languageCode]!['account']!;
  String get privacy => _localizedValues[locale.languageCode]!['privacy']!;
  String get termsOfService =>
      _localizedValues[locale.languageCode]!['termsOfService']!;
  String get helpSupport =>
      _localizedValues[locale.languageCode]!['helpSupport']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get deleteAccount =>
      _localizedValues[locale.languageCode]!['deleteAccount']!;

  // Resources
  String get categories =>
      _localizedValues[locale.languageCode]!['categories']!;
  String get featuredResources =>
      _localizedValues[locale.languageCode]!['featuredResources']!;
  String get allResources =>
      _localizedValues[locale.languageCode]!['allResources']!;
  String get stressManagement =>
      _localizedValues[locale.languageCode]!['stressManagement']!;
  String get anxiety => _localizedValues[locale.languageCode]!['anxiety']!;
  String get depression =>
      _localizedValues[locale.languageCode]!['depression']!;
  String get copingSkills =>
      _localizedValues[locale.languageCode]!['copingSkills']!;
  String get positivePsychology =>
      _localizedValues[locale.languageCode]!['positivePsychology']!;
  String get managingAnxiety =>
      _localizedValues[locale.languageCode]!['managingAnxiety']!;
  String get managingAnxietyDesc =>
      _localizedValues[locale.languageCode]!['managingAnxietyDesc']!;
  String get breathingExercise =>
      _localizedValues[locale.languageCode]!['breathingExercise']!;
  String get breathingExerciseDesc =>
      _localizedValues[locale.languageCode]!['breathingExerciseDesc']!;
  String get understandingDepression =>
      _localizedValues[locale.languageCode]!['understandingDepression']!;
  String get understandingDepressionDesc =>
      _localizedValues[locale.languageCode]!['understandingDepressionDesc']!;
  String get muscleRelaxation =>
      _localizedValues[locale.languageCode]!['muscleRelaxation']!;
  String get muscleRelaxationDesc =>
      _localizedValues[locale.languageCode]!['muscleRelaxationDesc']!;
  String get buildingSelfEsteem =>
      _localizedValues[locale.languageCode]!['buildingSelfEsteem']!;
  String get buildingSelfEsteemDesc =>
      _localizedValues[locale.languageCode]!['buildingSelfEsteemDesc']!;
  String get read15min => _localizedValues[locale.languageCode]!['read15min']!;
  String get read20min => _localizedValues[locale.languageCode]!['read20min']!;
  String get audio10min =>
      _localizedValues[locale.languageCode]!['audio10min']!;
  String get video15min =>
      _localizedValues[locale.languageCode]!['video15min']!;
  String get article => _localizedValues[locale.languageCode]!['article']!;
  String get audio => _localizedValues[locale.languageCode]!['audio']!;
  String get video => _localizedValues[locale.languageCode]!['video']!;
  String get start => _localizedValues[locale.languageCode]!['start']!;

  // Theme and Design
  String get themeSettings =>
      _localizedValues[locale.languageCode]!['themeSettings']!;
  String get darkMode => _localizedValues[locale.languageCode]!['darkMode']!;
  String get lightMode => _localizedValues[locale.languageCode]!['lightMode']!;
  String get systemMode =>
      _localizedValues[locale.languageCode]!['systemMode']!;

  // Settings
  String get preferences =>
      _localizedValues[locale.languageCode]!['preferences']!;
  String get language => _localizedValues[locale.languageCode]!['language']!;
  String get changePassword =>
      _localizedValues[locale.languageCode]!['changePassword']!;
  String get editProfile =>
      _localizedValues[locale.languageCode]!['editProfile']!;
  String get name => _localizedValues[locale.languageCode]!['name']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get currentPassword =>
      _localizedValues[locale.languageCode]!['currentPassword']!;
  String get newPassword =>
      _localizedValues[locale.languageCode]!['newPassword']!;
  String get profileUpdatedSuccessfully =>
      _localizedValues[locale.languageCode]!['profileUpdatedSuccessfully']!;
  String get failedToUpdateProfile =>
      _localizedValues[locale.languageCode]!['failedToUpdateProfile']!;
  String get passwordChangedSuccessfully =>
      _localizedValues[locale.languageCode]!['passwordChangedSuccessfully']!;
  String get failedToChangePassword =>
      _localizedValues[locale.languageCode]!['failedToChangePassword']!;
  String get languageChangedTo =>
      _localizedValues[locale.languageCode]!['languageChangedTo']!;
  String get areYouSureYouWantToLogout =>
      _localizedValues[locale.languageCode]!['areYouSureYouWantToLogout']!;

  // Profile completion
  String get completeProfile =>
      _localizedValues[locale.languageCode]!['completeProfile']!;
  String get uploadProfilePicture =>
      _localizedValues[locale.languageCode]!['uploadProfilePicture']!;
  String get changeProfilePicture =>
      _localizedValues[locale.languageCode]!['changeProfilePicture']!;
  String get takePhoto => _localizedValues[locale.languageCode]!['takePhoto']!;
  String get chooseFromGallery =>
      _localizedValues[locale.languageCode]!['chooseFromGallery']!;
  String get removePhoto =>
      _localizedValues[locale.languageCode]!['removePhoto']!;
  String get firstName => _localizedValues[locale.languageCode]!['firstName']!;
  String get lastName => _localizedValues[locale.languageCode]!['lastName']!;
  String get bio => _localizedValues[locale.languageCode]!['bio']!;
  String get phone => _localizedValues[locale.languageCode]!['phone']!;
  String get birthDate => _localizedValues[locale.languageCode]!['birthDate']!;
  String get gender => _localizedValues[locale.languageCode]!['gender']!;
  String get male => _localizedValues[locale.languageCode]!['male']!;
  String get female => _localizedValues[locale.languageCode]!['female']!;
  String get other => _localizedValues[locale.languageCode]!['other']!;
  String get preferNotToSay =>
      _localizedValues[locale.languageCode]!['preferNotToSay']!;
  String get profilePicture =>
      _localizedValues[locale.languageCode]!['profilePicture']!;
  String get profileCompleted =>
      _localizedValues[locale.languageCode]!['profileCompleted']!;
  String get pleaseCompleteYourProfile =>
      _localizedValues[locale.languageCode]!['pleaseCompleteYourProfile']!;
  String get requiredField =>
      _localizedValues[locale.languageCode]!['requiredField']!;
  String get tellUsAboutYourself =>
      _localizedValues[locale.languageCode]!['tellUsAboutYourself']!;
  String get personalInformation =>
      _localizedValues[locale.languageCode]!['personalInformation']!;
  String get changePhoto =>
      _localizedValues[locale.languageCode]!['changePhoto']!;
  String get fullName => _localizedValues[locale.languageCode]!['fullName']!;
  String get enterYourFullName =>
      _localizedValues[locale.languageCode]!['enterYourFullName']!;
  String get pleaseEnterYourName =>
      _localizedValues[locale.languageCode]!['pleaseEnterYourName']!;
  String get nameMustBeAtLeast2Characters =>
      _localizedValues[locale.languageCode]!['nameMustBeAtLeast2Characters']!;
  String get skipForNow =>
      _localizedValues[locale.languageCode]!['skipForNow']!;

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
      'date': 'Date',

      // Onboarding
      'onboardingWelcomeTitle': 'Welcome to Connect & Thrive',
      'onboardingWelcomeDesc':
          'Your safe space for mental health support, designed specifically for teenagers in Tunisia',
      'onboardingMoodTitle': 'Track Your Mood',
      'onboardingMoodDesc':
          'Monitor your emotions daily and discover patterns to improve your mental wellbeing',
      'onboardingCommunityTitle': 'Connect with Community',
      'onboardingCommunityDesc':
          'Join supportive communities and connect with peers who understand your journey',
      'skip': 'Skip',

      // Authentication
      'welcomeBack': 'Welcome Back',
      'login': 'Login',
      'loginSubtitle': 'Sign in to continue your mental health journey',
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
      'registerSubtitle':
          'Join Connect & Thrive and start your mental health journey',
      'confirmPassword': 'Confirm Password',
      'pleaseConfirmPassword': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'registrationSuccess': 'Registration successful! Please log in.',
      'registrationFailed': 'Registration failed. Please try again.',
      'alreadyHaveAccountSignIn': 'Already have an account? Sign in',

      // Journal
      'newJournalEntry': 'New Journal Entry',
      'writeYourThoughts': 'Write your thoughts...',
      'moodToday': 'Mood Today',
      'addPhoto': 'Add Photo',
      'entries': 'Entries',
      'journalSaved': 'Journal saved',
      'journalUpdated': 'Journal updated',
      'journalDeleted': 'Journal deleted',
      'confirmDeleteJournal':
          'Are you sure you want to delete this journal entry?',
      'journalSubtitle': 'Track your thoughts and emotions',
      'moodTracker': 'Mood Tracker',
      'howAreYouFeeling': 'How are you feeling today?',

      // Forums
      'communityForums': 'Community Forums',
      'allForums': 'All Forums',
      'myForums': 'My Forums',
      'newForum': 'New Forum',
      'members': 'members',
      'posts': 'posts',
      'viewForum': 'View Forum',
      'joinForum': 'Join Forum',
      'noForumsJoinedYet': 'No forums joined yet',
      'noForumsAvailable': 'No forums available',
      'joinSomeForumsToSeeThem': 'Join some forums to see them here',
      'beTheFirstToCreateForum': 'Be the first to create a forum!',
      'createFirstForum': 'Create First Forum',
      'participants': 'Participants',
      'leaveForum': 'Leave Forum',
      'createdBy': 'Created by',
      'join': 'Join',
      'leave': 'Leave',

      // Home Screen
      'goodMorning': 'Good Morning',
      'goodAfternoon': 'Good Afternoon',
      'goodEvening': 'Good Evening',
      'todayMood': 'Today\'s Mood',
      'quickActions': 'Quick Actions',
      'recentActivity': 'Recent Activity',

      // Mood & Emotions
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
      'aiAssistantTitle': 'AI Mental Health Assistant',
      'aiWelcomeMessage':
          'Hello! I\'m here to provide supportive guidance and general wellness advice.',
      'aiDisclaimerTitle': 'Important',
      'aiDisclaimerText':
          'I am an AI assistant, not a licensed psychiatrist or medical professional. For serious mental health concerns, please consult licensed professionals.',
      'aiHowCanIHelp': 'How can I help you today?',
      'aiDisclaimerBanner':
          'AI Assistant - Not a substitute for professional medical advice',
      'aiInputHint': 'Share your thoughts or ask for support...',
      'aiErrorMessage':
          'I apologize, but I\'m having trouble processing your message. Please try again.',

      // Doctors
      'findDoctor': 'Find a Doctor',
      'bookAppointment': 'Book Appointment',
      'available': 'Available',
      'notAvailable': 'Not Available',
      'rating': 'Rating',
      'reviews': 'Reviews',
      'searchDoctorsHint': 'Search doctors by name, specialty...',
      'location': 'Location',
      'specialty': 'Specialty',
      'all': 'All',
      'contact': 'Contact',
      'voluntaryService': 'Voluntary Service - Free',

      // Resources
      'categories': 'Categories',
      'featuredResources': 'Featured Resources',
      'allResources': 'All Resources',
      'articles': 'Articles',
      'videos': 'Videos',
      'exercises': 'Exercises',
      'stressManagement': 'Stress Management',
      'anxiety': 'Anxiety',
      'depression': 'Depression',
      'copingSkills': 'Coping Skills',
      'positivePsychology': 'Positive Psychology',
      'managingAnxiety': 'Managing Anxiety',
      'managingAnxietyDesc':
          'Learn effective techniques to manage and reduce anxiety in daily life',
      'breathingExercise': 'Breathing Exercise',
      'breathingExerciseDesc':
          'Simple breathing techniques to calm your mind and reduce stress',
      'understandingDepression': 'Understanding Depression',
      'understandingDepressionDesc':
          'Learn about depression, its symptoms, and effective coping strategies',
      'muscleRelaxation': 'Progressive Muscle Relaxation',
      'muscleRelaxationDesc':
          'Guided technique to release physical tension and mental stress',
      'buildingSelfEsteem': 'Building Self-Esteem',
      'buildingSelfEsteemDesc':
          'Practical exercises to develop confidence and positive self-image',
      'read15min': 'Read • 15 min',
      'read20min': 'Read • 20 min',
      'audio10min': 'Audio • 10 min',
      'video15min': 'Video • 15 min',
      'article': 'Article',
      'audio': 'Audio',
      'video': 'Video',
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
      'themeSettings': 'Theme Settings',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'systemMode': 'System Mode',
      'preferences': 'Preferences',
      'security': 'Security',
      'changePassword': 'Change Password',
      'editProfile': 'Edit Profile',
      'profile': 'Profile',
      'name': 'Name',
      'email': 'Email',
      'currentPassword': 'Current Password',
      'newPassword': 'New Password',
      'confirmPassword': 'Confirm Password',
      'language': 'Language',
      'completeProfile': 'Complete Profile',
      'uploadProfilePicture': 'Upload Profile Picture',
      'changeProfilePicture': 'Change Profile Picture',
      'takePhoto': 'Take a Photo',
      'chooseFromGallery': 'Choose from Gallery',
      'removePhoto': 'Remove Photo',
      'firstName': 'First Name',
      'lastName': 'Last Name',
      'bio': 'Bio',
      'phone': 'Phone Number',
      'birthDate': 'Birth Date',
      'gender': 'Gender',
      'male': 'Male',
      'female': 'Female',
      'other': 'Other',
      'preferNotToSay': 'Prefer not to say',
      'profilePicture': 'Profile Picture',
      'profileCompleted': 'Profile completed successfully',
      'pleaseCompleteYourProfile':
          'Please complete your profile for a better experience',
      'requiredField': 'This field is required',
      'tellUsAboutYourself': 'Tell us about yourself',
      'personalInformation': 'Personal Information',
      'changePhoto': 'Change Photo',
      'addPhoto': 'Add Photo',
      'fullName': 'Full Name',
      'enterYourFullName': 'Enter your full name',
      'pleaseEnterYourName': 'Please enter your name',
      'nameMustBeAtLeast2Characters': 'Name must be at least 2 characters',
      'skipForNow': 'Skip for now',
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
      'date': 'التاريخ',

      // Onboarding
      'onboardingWelcomeTitle': 'مرحباً في كونيكت & ثرايف',
      'onboardingWelcomeDesc':
          'مساحتك الآمنة لدعم الصحة النفسية، مصممة خصيصاً للمراهقين في تونس',
      'onboardingMoodTitle': 'تتبع مزاجك',
      'onboardingMoodDesc':
          'راقب مشاعرك يومياً واكتشف الأنماط لتحسين صحتك النفسية',
      'onboardingCommunityTitle': 'تواصل مع المجتمع',
      'onboardingCommunityDesc':
          'انضم إلى مجتمعات داعمة وتواصل مع أقرانك الذين يفهمون رحلتك',
      'skip': 'تخطي',

      // Authentication
      'welcomeBack': 'مرحباً بعودتك',
      'login': 'تسجيل الدخول',
      'loginSubtitle': 'سجل الدخول لمتابعة رحلتك في الصحة النفسية',
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
      'registerSubtitle':
          'انضم إلى Connect & Thrive وابدأ رحلتك في الصحة النفسية',
      'confirmPassword': 'تأكيد كلمة المرور',
      'pleaseConfirmPassword': 'يرجى تأكيد كلمة المرور',
      'passwordsDoNotMatch': 'كلمات المرور غير متطابقة',
      'registrationSuccess': 'تم التسجيل بنجاح! يرجى تسجيل الدخول.',
      'registrationFailed': 'فشل التسجيل. يرجى المحاولة مرة أخرى.',
      'alreadyHaveAccountSignIn': 'هل لديك حساب بالفعل؟ سجل الدخول',

      // Journal
      'newJournalEntry': 'مدخل جديد',
      'writeYourThoughts': 'اكتب أفكارك...',
      'moodToday': 'مزاج اليوم',
      'addPhoto': 'إضافة صورة',
      'entries': 'المدخلات',
      'journalSaved': 'تم حفظ المذكرة',
      'journalUpdated': 'تم تحديث المذكرة',
      'journalDeleted': 'تم حذف المذكرة',
      'confirmDeleteJournal': 'هل أنت متأكد أنك تريد حذف هذه المذكرة؟',
      'journalSubtitle': 'تتبع أفكارك ومشاعرك',
      'moodTracker': 'متتبع المزاج',
      'howAreYouFeeling': 'كيف تشعر اليوم؟',

      // Forums
      'communityForums': 'منتديات المجتمع',
      'allForums': 'جميع المنتديات',
      'myForums': 'منتدياتي',
      'newForum': 'منتدى جديد',
      'members': 'أعضاء',
      'posts': 'منشورات',
      'viewForum': 'عرض المنتدى',
      'joinForum': 'انضم إلى المنتدى',
      'noForumsJoinedYet': 'لم تنضم إلى أي منتدى بعد',
      'noForumsAvailable': 'لا توجد منتديات متاحة',
      'joinSomeForumsToSeeThem': 'انضم إلى بعض المنتديات لرؤيتها هنا',
      'beTheFirstToCreateForum': 'كن أول من ينشئ منتدى!',
      'createFirstForum': 'إنشاء أول منتدى',
      'participants': 'المشاركون',
      'leaveForum': 'مغادرة المنتدى',
      'createdBy': 'تم الإنشاء بواسطة',
      'join': 'انضم',
      'leave': 'غادر',

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
      'aiAssistantTitle': 'المساعد الذكي للصحة النفسية',
      'aiWelcomeMessage':
          'مرحباً! أنا هنا لتقديم إرشادات داعمة ونصائح عامة للعافية.',
      'aiDisclaimerTitle': 'مهم',
      'aiDisclaimerText':
          'أنا مساعد ذكاء اصطناعي، ولست طبيب نفسي مرخصاً أو محترفاً طبياً. لمخاوف الصحة النفسية الجدية، يرجى استشارة المحترفين المرخصين.',
      'aiHowCanIHelp': 'كيف يمكنني مساعدتك اليوم؟',
      'aiDisclaimerBanner':
          'المساعد الذكي - ليس بديلاً عن المشورة الطبية المهنية',
      'aiInputHint': 'شارك أفكارك أو اطلب الدعم...',
      'aiErrorMessage':
          'أعتذر، لكن أواجه صعوبة في معالجة رسالتك. يرجى المحاولة مرة أخرى.',

      // Doctors
      'findDoctor': 'العثور على طبيب',
      'bookAppointment': 'حجز موعد',
      'available': 'متاح',
      'notAvailable': 'غير متاح',
      'rating': 'التقييم',
      'reviews': 'المراجعات',
      'searchDoctorsHint': 'ابحث عن الأطباء بالاسم أو التخصص...',
      'location': 'الموقع',
      'specialty': 'التخصص',
      'all': 'الكل',
      'contact': 'اتصل',
      'voluntaryService': 'خدمة تطوعية - مجانية',

      // Resources
      'categories': 'الفئات',
      'featuredResources': 'الموارد المميزة',
      'allResources': 'جميع الموارد',
      'articles': 'مقالات',
      'videos': 'فيديوهات',
      'exercises': 'تمارين',
      'stressManagement': 'إدارة التوتر',
      'anxiety': 'القلق',
      'depression': 'الاكتئاب',
      'copingSkills': 'مهارات التكيف',
      'positivePsychology': 'علم النفس الإيجابي',
      'managingAnxiety': 'إدارة القلق',
      'managingAnxietyDesc':
          'تعلم تقنيات فعالة لإدارة وتقليل القلق في الحياة اليومية',
      'breathingExercise': 'تمرين التنفس',
      'breathingExerciseDesc': 'تقنيات تنفس بسيطة لتهدئة عقلك وتقليل التوتر',
      'understandingDepression': 'فهم الاكتئاب',
      'understandingDepressionDesc':
          'تعلم عن الاكتئاب وأعراضه واستراتيجيات التعامل الفعالة',
      'muscleRelaxation': 'استرخاء العضلات التدريجي',
      'muscleRelaxationDesc': 'تقنية موجهة لإطلاق التوتر الجسدي والعقلي',
      'buildingSelfEsteem': 'بناء تقدير الذات',
      'buildingSelfEsteemDesc':
          'تمارين عملية لتطوير الثقة بالنفس والصورة الإيجابية',
      'read15min': 'قراءة • 15 دقيقة',
      'read20min': 'قراءة • 20 دقيقة',
      'audio10min': 'صوت • 10 دقائق',
      'video15min': 'فيديو • 15 دقيقة',
      'article': 'مقال',
      'audio': 'صوت',
      'video': 'فيديو',
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
      'themeSettings': 'إعدادات المظهر',
      'darkMode': 'الوضع الداكن',
      'lightMode': 'الوضع الفاتح',
      'systemMode': 'وضع النظام',
      'preferences': 'التفضيلات',
      'security': 'الأمان',
      'changePassword': 'تغيير كلمة المرور',
      'editProfile': 'تعديل الملف الشخصي',
      'profile': 'الملف الشخصي',
      'name': 'الاسم',
      'email': 'البريد الإلكتروني',
      'currentPassword': 'كلمة المرور الحالية',
      'newPassword': 'كلمة المرور الجديدة',
      'confirmPassword': 'تأكيد كلمة المرور',
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'language': 'اللغة',
      'profileUpdatedSuccessfully': 'تم تحديث الملف الشخصي بنجاح',
      'failedToUpdateProfile': 'فشل تحديث الملف الشخصي',
      'passwordChangedSuccessfully': 'تم تغيير كلمة المرور بنجاح',
      'failedToChangePassword': 'فشل تغيير كلمة المرور',
      'languageChangedTo': 'تم تغيير اللغة إلى',
      'areYouSureYouWantToLogout': 'هل أنت متأكد أنك تريد تسجيل الخروج؟',
      'completeProfile': 'إكمال الملف الشخصي',
      'uploadProfilePicture': 'رفع صورة الملف الشخصي',
      'changeProfilePicture': 'تغيير صورة الملف الشخصي',
      'takePhoto': 'التقاط صورة',
      'chooseFromGallery': 'اختيار من المعرض',
      'removePhoto': 'إزالة الصورة',
      'firstName': 'الاسم الأول',
      'lastName': 'الاسم الأخير',
      'bio': 'السيرة الذاتية',
      'phone': 'رقم الهاتف',
      'birthDate': 'تاريخ الميلاد',
      'gender': 'الجنس',
      'male': 'ذكر',
      'female': 'أنثى',
      'other': 'آخر',
      'preferNotToSay': 'يفضل عدم الإفصاح',
      'profilePicture': 'صورة الملف الشخصي',
      'profileCompleted': 'تم إكمال الملف الشخصي بنجاح',
      'pleaseCompleteYourProfile':
          'يرجى إكمال ملفك الشخصي للاستمتاع بتجربة أفضل',
      'requiredField': 'هذا الحقل مطلوب',
      'tellUsAboutYourself': 'أخبرنا عن نفسك',
      'personalInformation': 'المعلومات الشخصية',
      'signInToContinue': 'تسجيل الدخول للمتابعة',
      'poweredBy': 'مدعوم من',
      'ministryOfYouthAndSports': 'وزارة الشباب والرياضة',
      'connectAndThrive': 'تواصل وازدهر',
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

      // Onboarding
      'onboardingWelcomeTitle': 'Bienvenue sur Connect & Thrive',
      'onboardingWelcomeDesc':
          'Votre espace sécurisé pour le soutien santé mentale, conçu spécifiquement pour les adolescents en Tunisie',
      'onboardingMoodTitle': 'Suivez votre humeur',
      'onboardingMoodDesc':
          'Surveillez vos émotions quotidiennement et découvrez des modèles pour améliorer votre bien-être mental',
      'onboardingCommunityTitle': 'Connectez-vous avec la communauté',
      'onboardingCommunityDesc':
          'Rejoignez des communautés de soutien et connectez-vous avec des pairs qui comprennent votre parcours',
      'skip': 'Passer',

      // Authentication
      'welcomeBack': 'Bienvenue',
      'login': 'Connexion',
      'loginSubtitle':
          'Connectez-vous pour continuer votre parcours de santé mentale',
      'register': 'S\'inscrire',
      'emailAddress': 'Adresse Email',
      'password': 'Mot de passe',
      'forgotPassword': 'Mot de passe oublié?',
      'signIn': 'Se connecter',
      'signUp': 'S\'inscrire',
      'orContinueWith': 'Ou continuer avec',
      'loginSuccess': 'Connexion réussie',
      'loginFailed':
          'Échec de la connexion. Veuillez vérifier vos identifiants.',
      'pleaseEnterEmail': 'Veuillez entrer votre email',
      'pleaseEnterValidEmail': 'Veuillez entrer une adresse email valide',
      'pleaseEnterPassword': 'Veuillez entrer votre mot de passe',
      'passwordMinLength':
          'Le mot de passe doit contenir au moins 6 caractères',
      'noAccountSignUp': 'Pas de compte? S\'inscrire',
      'continueAsGuest': 'Continuer en tant qu\'invité',
      'createAccount': 'Créer un compte',
      'registerSubtitle':
          'Rejoignez Connect & Thrive et commencez votre parcours de santé mentale',
      'confirmPassword': 'Confirmer le mot de passe',
      'pleaseConfirmPassword': 'Veuillez confirmer votre mot de passe',
      'passwordsDoNotMatch': 'Les mots de passe ne correspondent pas',
      'registrationSuccess': 'Inscription réussie! Veuillez vous connecter.',
      'registrationFailed': 'Échec de l\'inscription. Veuillez réessayer.',
      'alreadyHaveAccountSignIn': 'Déjà un compte? Se connecter',

      // Journal
      'newJournalEntry': 'Nouvelle entrée de journal',
      'writeYourThoughts':
          'Comment vous sentez-vous aujourd\'hui? Qu\'est-ce qui vous préoccupe?',
      'moodToday': 'Humeur du jour',
      'addPhoto': 'Ajouter une photo',
      'entries': 'Entrées',
      'journalSaved': 'Entrée de journal enregistrée avec succès',
      'journalUpdated': 'Entrée de journal mise à jour avec succès',
      'journalDeleted': 'Entrée de journal supprimée avec succès',
      'confirmDeleteJournal':
          'Êtes-vous sûr de vouloir supprimer cette entrée de journal?',

      // Forums
      'communityForums': 'Forums Communautaires',
      'allForums': 'Tous les Forums',
      'myForums': 'Mes Forums',
      'newForum': 'Nouveau Forum',
      'members': 'membres',
      'posts': 'publications',
      'viewForum': 'Voir le Forum',
      'joinForum': 'Rejoindre le Forum',
      'noForumsJoinedYet': 'Aucun forum rejoint pour l\'instant',
      'noForumsAvailable': 'Aucun forum disponible',
      'joinSomeForumsToSeeThem': 'Rejoignez des forums pour les voir ici',
      'beTheFirstToCreateForum': 'Soyez le premier à créer un forum!',
      'createFirstForum': 'Créer le Premier Forum',
      'participants': 'Participants',
      'leaveForum': 'Quitter le Forum',
      'createdBy': 'Créé par',
      'join': 'Rejoindre',
      'leave': 'Quitter',

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
      'aiAssistantTitle': 'Assistant IA Santé Mentale',
      'aiWelcomeMessage':
          'Bonjour! Je suis votre assistant IA pour la santé mentale. Je suis ici pour vous offrir du soutien, des conseils et des ressources pour vous aider à naviguer dans vos défis émotionnels.',
      'aiDisclaimerTitle': 'Avertissement',
      'aiDisclaimerText':
          'Je ne suis pas un remplacement pour un professionnel de santé mentale. En cas d\'urgence, contactez les services d\'urgence ou un professionnel de santé mentale.',
      'aiDisclaimerBanner':
          'Ceci est un assistant IA, pas un remplacement pour un professionnel de santé mentale.',
      'aiHowCanIHelp': 'Comment puis-je vous aider aujourd\'hui?',
      'aiInputHint': 'Écrivez votre message...',
      'aiErrorMessage':
          'Désolé, j\'ai rencontré une erreur. Veuillez réessayer.',

      // Doctors
      'findDoctor': 'Trouver un Médecin',
      'bookAppointment': 'Prendre Rendez-vous',
      'available': 'Disponible',
      'notAvailable': 'Non Disponible',
      'rating': 'Note',
      'reviews': 'Avis',
      'searchDoctorsHint': 'Rechercher des médecins par nom, spécialité...',
      'location': 'Emplacement',
      'specialty': 'Spécialité',
      'all': 'Tous',
      'contact': 'Contacter',
      'voluntaryService': 'Service Volontaire - Gratuit',

      // Resources
      'categories': 'Catégories',
      'featuredResources': 'Ressources en Vedette',
      'allResources': 'Toutes les Ressources',
      'articles': 'Articles',
      'videos': 'Vidéos',
      'exercises': 'Exercices',
      'stressManagement': 'Gestion du Stress',
      'anxiety': 'Anxiété',
      'depression': 'Dépression',
      'copingSkills': 'Compétences d\'Adaptation',
      'positivePsychology': 'Psychologie Positive',
      'managingAnxiety': 'Gérer l\'Anxiété',
      'managingAnxietyDesc':
          'Apprenez des techniques efficaces pour gérer et réduire l\'anxiété au quotidien',
      'breathingExercise': 'Exercice de Respiration',
      'breathingExerciseDesc':
          'Techniques de respiration simples pour calmer votre esprit et réduire le stress',
      'understandingDepression': 'Comprendre la Dépression',
      'understandingDepressionDesc':
          'Apprenez à connaître la dépression, ses symptômes et des stratégies d adaptation efficaces',
      'muscleRelaxation': 'Relaxation Musculaire Progressive',
      'muscleRelaxationDesc':
          'Technique guidée pour libérer la tension physique et mentale',
      'buildingSelfEsteem': 'Construire l Estime de Soi',
      'buildingSelfEsteemDesc':
          'Des exercices pratiques pour développer la confiance et l image positive de soi',
      'read15min': 'Lire • 15 min',
      'read20min': 'Lire • 20 min',
      'audio10min': 'Audio • 10 min',
      'video15min': 'Vidéo • 15 min',
      'article': 'Article',
      'audio': 'Audio',
      'video': 'Vidéo',
      'meditation': 'Méditation',
      'readMore': 'Lire la suite',
      'watchNow': 'Regarder maintenant',

      // Settings
      'account': 'Compte',
      'privacy': 'Confidentialité',
      'termsOfService': 'Conditions d\'Utilisation',
      'helpSupport': 'Aide & Support',
      'logout': 'Déconnexion',
      'deleteAccount': 'Supprimer le Compte',

      // Theme and Design
      'themeSettings': 'Paramètres du thème',
      'darkMode': 'Mode sombre',
      'lightMode': 'Mode clair',
      'systemMode': 'Mode système',
      'preferences': 'Préférences',
      'security': 'Sécurité',
      'changePassword': 'Changer le mot de passe',
      'editProfile': 'Modifier le profil',
      'profile': 'Profil',
      'name': 'Nom',
      'email': 'Email',
      'currentPassword': 'Mot de passe actuel',
      'newPassword': 'Nouveau mot de passe',
      'confirmPassword': 'Confirmer le mot de passe',
      'save': 'Enregistrer',
      'cancel': 'Annuler',
      'language': 'Langue',
      'profileUpdatedSuccessfully': 'Profil mis à jour avec succès',
      'failedToUpdateProfile': 'Échec de la mise à jour du profil',
      'passwordChangedSuccessfully': 'Mot de passe changé avec succès',
      'failedToChangePassword': 'Échec de la modification du mot de passe',
      'languageChangedTo': 'Langue changée en',
      'areYouSureYouWantToLogout':
          'Êtes-vous sûr de vouloir vous déconnecter ?',
      'completeProfile': 'Compléter le profil',
      'uploadProfilePicture': 'Télécharger une photo de profil',
      'changeProfilePicture': 'Changer la photo de profil',
      'takePhoto': 'Prendre une photo',
      'chooseFromGallery': 'Choisir depuis la galerie',
      'removePhoto': 'Supprimer la photo',
      'firstName': 'Prénom',
      'lastName': 'Nom',
      'bio': 'Biographie',
      'phone': 'Numéro de téléphone',
      'birthDate': 'Date de naissance',
      'gender': 'Genre',
      'male': 'Homme',
      'female': 'Femme',
      'other': 'Autre',
      'preferNotToSay': 'Préfère ne pas répondre',
      'profilePicture': 'Photo de profil',
      'profileCompleted': 'Profil complété avec succès',
      'pleaseCompleteYourProfile':
          'Veuillez compléter votre profil pour une meilleure expérience',
      'requiredField': 'Ce champ est requis',
      'tellUsAboutYourself': 'Parlez-nous de vous',
      'personalInformation': 'Informations personnelles',
      'signInToContinue': 'Connectez-vous pour continuer',
      'poweredBy': 'Propulsé par',
      'ministryOfYouthAndSports': 'Ministère de la Jeunesse et des Sports',
      'connectAndThrive': 'Connectez et Prospérez',
      'profileCompleted': 'Profile completed successfully',
      'pleaseCompleteYourProfile':
          'Please complete your profile for a better experience',
      'requiredField': 'This field is required',
      'tellUsAboutYourself': 'Tell us about yourself',
      'personalInformation': 'Personal Information',
      'changePhoto': 'Changer la photo',
      'addPhoto': 'Ajouter une photo',
      'fullName': 'Nom complet',
      'enterYourFullName': 'Entrez votre nom complet',
      'pleaseEnterYourName': 'Veuillez entrer votre nom',
      'nameMustBeAtLeast2Characters':
          'Le nom doit contenir au moins 2 caractères',
      'skipForNow': 'Passer pour le moment',
      'changePhoto': 'Changer la photo',
      'addPhoto': 'Ajouter une photo',
      'fullName': 'Nom complet',
      'enterYourFullName': 'Entrez votre nom complet',
      'pleaseEnterYourName': 'Veuillez entrer votre nom',
      'nameMustBeAtLeast2Characters':
          'Le nom doit contenir au moins 2 caractères',
      'skipForNow': 'Passer pour le moment',
    },
  };
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
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
