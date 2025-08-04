import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_thrive_app/l10n/app_localizations.dart';
import 'package:connect_thrive_app/services/auth_provider.dart';
import 'package:connect_thrive_app/widgets/language_switcher.dart';
import 'package:connect_thrive_app/widgets/theme_switcher.dart';
import 'package:connect_thrive_app/screens/home_screen.dart';
import 'package:connect_thrive_app/screens/resources_screen.dart';
import 'package:connect_thrive_app/screens/forums_screen_modern.dart';
import 'package:connect_thrive_app/screens/journal_list_screen_modern.dart';
import 'package:connect_thrive_app/screens/ai_chat_screen.dart';
import 'package:connect_thrive_app/screens/doctors_screen_modern.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ResourcesScreen(),
    const ForumsScreen(),
    const JournalListScreen(),
    const DoctorsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AIChatScreen()),
          );
        },
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        child: const Icon(Icons.psychology),
        tooltip: AppLocalizations.of(context)?.aiAssistant ?? 'AI Mental Health Assistant',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        actions: [
          const ThemeSwitcher(),
          const SizedBox(width: 8),
          const LanguageSwitcher(),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: AppLocalizations.of(context)?.logout ?? 'Logout',
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: AppLocalizations.of(context)?.home ?? 'Home',
          ),
          NavigationDestination(
            icon: const Icon(Icons.article_outlined),
            selectedIcon: const Icon(Icons.article),
            label: AppLocalizations.of(context)?.resources ?? 'Resources',
          ),
          NavigationDestination(
            icon: const Icon(Icons.forum_outlined),
            selectedIcon: const Icon(Icons.forum),
            label: AppLocalizations.of(context)?.forums ?? 'Forums',
          ),
          NavigationDestination(
            icon: const Icon(Icons.book),
            selectedIcon: const Icon(Icons.book),
            label: AppLocalizations.of(context)?.journal ?? 'Journal',
          ),
          NavigationDestination(
            icon: const Icon(Icons.medical_services_outlined),
            selectedIcon: const Icon(Icons.medical_services),
            label: AppLocalizations.of(context)?.doctors ?? 'Doctors',
          ),
        ],
      ),
    );
  }
}
