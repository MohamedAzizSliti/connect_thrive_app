import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_thrive_app/services/language_provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (languageCode) {
        languageProvider.changeLanguage(languageCode);
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'fr', child: Text('Français')),
        const PopupMenuItem(value: 'ar', child: Text('العربية')),
      ],
    );
  }
}
