# i18n Usage Guide - Connect & Thrive App

## Overview
Your Flutter app already has a complete internationalization (i18n) system set up with support for Arabic and French languages.

## How to Use Translations

### 1. Import the Localizations
```dart
import 'package:connect_thrive_app/l10n/app_localizations.dart';
```

### 2. Use Translations in Widgets
```dart
// In any widget's build method:
AppLocalizations.of(context)?.home ?? 'Fallback Text'

// Example usage:
Text(AppLocalizations.of(context)?.home ?? 'Home')
AppBar(
  title: Text(AppLocalizations.of(context)?.appTitle ?? 'App Title'),
)
```

### 3. Available Translation Keys

#### Navigation & Main Features
- `home` - Home
- `resources` - Resources
- `forums` - Forums
- `journal` - Journal
- `doctors` - Doctors
- `aiAssistant` - AI Assistant

#### Common UI Elements
- `welcome` - Welcome
- `settings` - Settings
- `language` - Language
- `notifications` - Notifications
- `profile` - Profile
- `search` - Search
- `save` - Save
- `cancel` - Cancel
- `delete` - Delete
- `edit` - Edit
- `confirm` - Confirm

#### Specialized Terms
- `mentalHealth` - Mental Health
- `workLifeBalance` - Work-Life Balance
- `mentalWellness` - Mental Wellness
- `productivity` - Productivity

### 4. Language Switching
The app includes a language switcher in the home screen's app bar. Users can switch between:
- **العربية** (Arabic)
- **Français** (French)

### 5. Adding New Languages

To add a new language (e.g., English):

1. **Update the supported locales in main.dart:**
```dart
supportedLocales: const [
  Locale('ar'),
  Locale('fr'), 
  Locale('en'), // Add this
],
```

2. **Update the delegate in app_localizations.dart:**
```dart
@override
bool isSupported(Locale locale) => ['ar', 'fr', 'en'].contains(locale.languageCode);
```

3. **Add translations to _localizedValues:**
```dart
'en': {
  'home': 'Home',
  'resources': 'Resources',
  // ... add all other keys
}
```

4. **Add new language option to language switchers:**
```dart
const PopupMenuItem<String>(
  value: 'en',
  child: Text('English'),
),
```

### 6. Adding New Translation Keys

1. **Add the getter in AppLocalizations class:**
```dart
String get myNewKey => _localizedValues[locale.languageCode]!['myNewKey']!;
```

2. **Add translations for all languages:**
```dart
'ar': {
  'myNewKey': 'النص الجديد',
  // ...
},
'fr': {
  'myNewKey': 'Nouveau texte',
  // ...
}
```

3. **Use in your widgets:**
```dart
Text(AppLocalizations.of(context)?.myNewKey ?? 'Default Text')
```

## Best Practices

1. **Always provide fallback text** using the `??` operator
2. **Use context-appropriate keys** for better organization
3. **Test in both languages** regularly
4. **Keep translations consistent** across the app
5. **Consider text direction** for RTL languages (Arabic)

## Testing Translations

Run the app and use the language switcher in the home screen to test both Arabic and French translations. The app will remember the user's language preference using SharedPreferences.

## RTL Support

The app automatically handles RTL layout for Arabic language thanks to Flutter's built-in RTL support when using MaterialApp with proper localization delegates.
