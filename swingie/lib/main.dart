import 'package:flutter/material.dart';
import 'screens/cover_page.dart';
import 'screens/landing_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'screens/onboarding_page.dart';

void main() {
  runApp(const SwingieApp());
}

class SwingieApp extends StatelessWidget {
  const SwingieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Start with CoverPage
      routes: {
        '/': (context) => const CoverPage(),
        '/landing': (context) => LandingPage(), // Route to LandingPage
        '/login': (context) => LoginPage(),     // Route to LoginPage
        '/signup': (context) => SignUpPage(),  // Route to SignUpPage
        '/onboarding': (context) => OnboardingPage(), // Route to OnboardingPage
      },
    );
  }
}
