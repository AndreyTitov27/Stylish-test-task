import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:stylish_test_task/styles.dart';
import 'package:stylish_test_task/presentation/widgets/stylish_text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 32.0,
          right: 32.0,
          top: MediaQuery.of(context).padding.top + 32.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 32.0,
          children: [
            Text('Welcome\nBack!', style: SignTextStyles.large, textAlign: TextAlign.left),
            StylishTextField(placeHolder: 'Email', icon: Icons.person),
            StylishTextField(isPassword: true, placeHolder: 'Password', icon: Icons.lock),
            CupertinoButton.filled(
              color: Color(0xFFF83758),
              minimumSize: Size(double.infinity, 55.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () {},
              child: Text('Login', style: SignTextStyles.buttonText),
            ),
            Row(
              spacing: 4.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create an Account', style: SignTextStyles.bottomText),
                TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/signUp'),
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsetsGeometry.zero,
                    minimumSize: Size(0.0, 0.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Sign Up', style: SignTextStyles.bottomTextRed),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}