import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:stylish_test_task/presentation/providers/auth_provider.dart';
import 'package:stylish_test_task/presentation/providers/storage_provider.dart';
import 'package:stylish_test_task/styles.dart';
import 'package:stylish_test_task/presentation/widgets/stylish_text_field.dart';
import 'package:stylish_test_task/utils/error_message_util.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  
  @override
  State<SignInScreen> createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

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
            StylishTextField(
              controller: emailController,
              placeHolder: 'Email',
              icon: Icons.person,
              onSubmitted: (_) => passwordFocus.requestFocus(),
            ),
            StylishTextField(
              isPassword: true,
              controller: passwordController,
              focusNode: passwordFocus,
              placeHolder: 'Password',
              icon: Icons.lock,
              onSubmitted: (_) => _onSignInTap(context),
            ),
            CupertinoButton.filled(
              color: Color(0xFFF83758),
              minimumSize: Size(double.infinity, 55.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () async => await _onSignInTap(context),
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
  Future<void> _onSignInTap(BuildContext context) async {
    if (!EmailValidator.validate(emailController.text.trim())) {
      showErrorMessage(context, 'Empty or Invalid email');
      return;
    } else if (passwordController.text.trim().length < 8) {
      showErrorMessage(context, 'Password must be at least 8 characters');
      return;
    }
    FocusScope.of(context).unfocus();
    final authProvider = context.read<AuthProvider>();
    final storageProvider = context.read<StorageProvider>();
    final success = await authProvider.signIn(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (success) {
      await storageProvider.loadText(authProvider.user!.uid);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      if (context.mounted) {
        showErrorMessage(context, authProvider.errorMessage ?? 'Something went wrong');
      }
    }
  }
}