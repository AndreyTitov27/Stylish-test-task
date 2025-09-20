import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish_test_task/presentation/screens/home_screen.dart';
import 'package:stylish_test_task/presentation/screens/onboarding_screen.dart';
import 'package:stylish_test_task/presentation/screens/set_up_screen.dart';
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
        '/onboarding': (_) => OnboardingScreen(),
        '/signIn': (_) => SignInScreen(),
        '/signUp': (_) => SignUpScreen(),
        '/setUp': (_) => SetUpScreen(),
        '/home': (_) => HomeScreen(),
      },
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        precacheImage(AssetImage('assets/images/home_screen_backgroung.png'), context);
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
          child: child!,
        );
      },
    );
  }
}