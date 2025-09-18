import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_test_task/presentation/widgets/stylish_text_field.dart';
import 'package:stylish_test_task/styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
            Text('Create an\naccount', style: SignTextStyles.large, textAlign: TextAlign.left),
            StylishTextField(placeHolder: 'Email', icon: Icons.person),
            StylishTextField(isPassword: true, placeHolder: 'Password', icon: Icons.lock),
            StylishTextField(isPassword: true, placeHolder: 'Confirm Password', icon: Icons.lock),
            CupertinoButton.filled(
              color: Color(0xFFF83758),
              minimumSize: Size(double.infinity, 55.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () {},
              child: Text('Create Account', style: SignTextStyles.buttonText),
            ),
            Row(
              spacing: 4.0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I Already Have an Account', style: SignTextStyles.bottomText),
                TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/signIn'),
                  style: TextButton.styleFrom(
                    overlayColor: Colors.transparent,
                    padding: EdgeInsetsGeometry.zero,
                    minimumSize: Size(0.0, 0.0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Login', style: SignTextStyles.bottomTextRed),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}