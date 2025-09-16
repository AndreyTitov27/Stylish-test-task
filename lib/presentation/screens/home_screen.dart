import 'package:flutter/material.dart';
import 'package:stylish_test_task/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsetsGeometry.only(top: MediaQuery.of(context).padding.top + 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Test completed', style: HomeTextStyles.large),
              SizedBox(height: 10.0),
              Text('You are signed in as:', style: HomeTextStyles.small),
              Text('{User.email}',  style: HomeTextStyles.small),
              SizedBox(height: 10.0),
              Text('Your text is:',  style: HomeTextStyles.small),
              Text('{User.text}',  style: HomeTextStyles.small),
            ],
          ),
        ),
      ),
    );
  }
}