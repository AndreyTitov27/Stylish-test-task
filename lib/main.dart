import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:stylish_test_task/app.dart';
import 'package:stylish_test_task/firebase_options.dart';
import 'package:stylish_test_task/presentation/providers/auth_provider.dart';
import 'package:stylish_test_task/presentation/providers/storage_provider.dart';
import 'package:stylish_test_task/services/storage_service.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  const minSplashDuration = Duration(seconds: 3);
  final startTime = DateTime.now();

  final sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final bool showOnboarding = sharedPreferences.getBool('firstLaunch') ?? true;
  final currentUser = auth.FirebaseAuth.instance.currentUser;
  String? userText;
  String initialRoute = '/signIn';
  if (currentUser != null) {
    final StorageService storage = StorageService();
    userText = await storage.loadText(currentUser.uid);
    if (userText == null) {
      initialRoute = '/setUp';
    } else {
      initialRoute = '/home';
    }
  } else if (showOnboarding) {
    initialRoute = '/onboarding';
    await sharedPreferences.setBool('firstLaunch', false);
  }

  final elapsedTime = DateTime.now().difference(startTime);
  if (elapsedTime < minSplashDuration) {
    await Future.delayed(minSplashDuration - elapsedTime);
  }
  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider(user: currentUser)),
        ChangeNotifierProvider<StorageProvider>(create: (_) => StorageProvider(userText: userText)),
      ],
      child: StylishApp(initialRoute: initialRoute),
    ),
  );
}
