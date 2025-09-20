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
      backgroundColor: Color(0xFF1C383C),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_screen_backgroung.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: 32.0,
            right: 32.0,
            top: MediaQuery.of(context).padding.top + 72.0,
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
              Spacer(),
              Padding(
                padding: EdgeInsetsGeometry.only(bottom:MediaQuery.of(context).padding.bottom + 16.0),
                child:  CupertinoButton.filled(
                  color: Color(0xFFF83758),
                  minimumSize: Size(double.infinity, 55.0),
                  borderRadius: BorderRadius.circular(4.0),
                  onPressed: () => _onLogOutTap(context),
                  child: Text('Log out', style: SignTextStyles.buttonText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _onLogOutTap(BuildContext context) async {
    await context.read<AuthProvider>().signOut();
    if (context.mounted) Navigator.pushReplacementNamed(context, '/signIn');
  }
}