import 'package:flutter/material.dart';
import 'package:stylish_test_task/presentation/screens/home_screen.dart';
import 'package:stylish_test_task/presentation/screens/onboarding_screen.dart';

class StylishApp extends StatelessWidget {
  final bool showOnboarding;
  const StylishApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: showOnboarding ? const OnboardingScreen() : const HomeScreen(),
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}