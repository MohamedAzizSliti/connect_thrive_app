import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connect_thrive_app/services/auth_provider.dart';
import 'package:connect_thrive_app/screens/onboarding_screen.dart';
import 'package:connect_thrive_app/screens/main_navigation.dart';
import 'package:connect_thrive_app/screens/create_profile_screen.dart';

class OnboardingWrapper extends StatelessWidget {
  const OnboardingWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Check if user is authenticated
        if (authProvider.isAuthenticated) {
          // Check if profile is complete
          if (authProvider.userProfile == null) {
            return const CreateProfileScreen();
          } else {
            return const MainNavigation();
          }
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
