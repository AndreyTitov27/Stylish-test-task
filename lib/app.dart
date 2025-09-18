import 'package:flutter/material.dart';
import 'package:stylish_test_task/presentation/screens/home_screen.dart';
import 'package:stylish_test_task/presentation/screens/onboarding_screen.dart';
import 'package:stylish_test_task/presentation/screens/sign_in_screen.dart';
import 'package:stylish_test_task/presentation/screens/sign_up_screen.dart';

class StylishApp extends StatelessWidget {
  final String initialRoute;
  const StylishApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}