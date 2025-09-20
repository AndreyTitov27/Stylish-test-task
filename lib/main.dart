import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stylish_test_task/app.dart';
import 'package:stylish_test_task/firebase_options.dart';
import 'package:stylish_test_task/presentation/providers/auth_provider.dart';
import 'package:stylish_test_task/presentation/providers/storage_provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  const minSplashDuration = Duration(seconds: 3);
  final startTime = DateTime.now();

  final sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final bool showOnboarding = sharedPreferences.getBool('firstLaunch') ?? true;
  String initialRoute = '/signIn';
  if (showOnboarding) {
    initialRoute = '/onboarding';
  }

  final elapsedTime = DateTime.now().difference(startTime);
  if (elapsedTime < minSplashDuration) {
    await Future.delayed(elapsedTime);
  }
  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<StorageProvider>(create: (_) => StorageProvider()),
      ],
      child: StylishApp(initialRoute: initialRoute),
    ),
  );
}
