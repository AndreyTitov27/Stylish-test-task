import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_test_task/presentation/providers/auth_provider.dart';
import 'package:stylish_test_task/presentation/providers/storage_provider.dart';
import 'package:stylish_test_task/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF1C383C),
      body: Stack(
        alignment: AlignmentGeometry.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_screen_backgroung.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  stops: [0.0, 0.24],
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha((255 * 0.63).round()),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 72.0,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Test completed', style: HomeTextStyles.large),
                  SizedBox(height: 10.0),
                  Text('You are signed in as:', style: HomeTextStyles.small),
                  Text(context.watch<AuthProvider>().user?.email ?? 'null',  style: HomeTextStyles.small),
                  SizedBox(height: 10.0),
                  Text('Your text is:',  style: HomeTextStyles.small),
                  Text(context.watch<StorageProvider>().userText ?? 'null',  style: HomeTextStyles.small),
                ],
              ),
            ),
          ),
          Positioned(
            left: 32.0,
            right: 32.0,
            bottom: MediaQuery.of(context).padding.bottom + 16.0,
            child: CupertinoButton.filled(
              color: Color(0xFFF83758),
              minimumSize: Size(double.infinity, 55.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () => _onLogOutTap(context),
              child: Text('Log out', style: SignTextStyles.buttonText),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _onLogOutTap(BuildContext context) async {
    await context.read<AuthProvider>().signOut();
    if (context.mounted) Navigator.pushReplacementNamed(context, '/signIn');
  }
}