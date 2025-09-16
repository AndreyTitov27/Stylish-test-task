import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stylish_test_task/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  //final bool showOnboarding = sharedPreferences.getBool('showOnboarding') ?? true;
  runApp(StylishApp(showOnboarding: true));
}
