import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:stylish_test_task/presentation/providers/auth_provider.dart';
import 'package:stylish_test_task/presentation/widgets/stylish_text_field.dart';
import 'package:stylish_test_task/utils/error_message_util.dart';
import 'package:stylish_test_task/utils/loading_dialog_util.dart';
import 'package:stylish_test_task/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            StylishTextField(
              controller: emailController,
              placeHolder: 'Email',
              icon: Icons.person,
              onSubmitted: (value) => passwordFocusNode.requestFocus(),
            ),
            StylishTextField(
              isPassword: true,
              controller: passwordController,
              focusNode: passwordFocusNode,
              placeHolder: 'Password',
              icon: Icons.lock,
              onSubmitted: (_) => confirmPasswordFocusNode.requestFocus(),
            ),
            StylishTextField(
              isPassword: true,
              controller: confirmPasswordController,
              focusNode: confirmPasswordFocusNode,
              placeHolder: 'Confirm Password',
              icon: Icons.lock,
              onSubmitted: (_) => _onSignUpTap(context),
            ),
            CupertinoButton.filled(
              color: Color(0xFFF83758),
              minimumSize: Size(double.infinity, 55.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () async => await _onSignUpTap(context),
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
  Future<void> _onSignUpTap(BuildContext context) async {
    if (!EmailValidator.validate(emailController.text.trim())) {
      showErrorMessage(context, 'Empty or Invalid email');
      return;
    } else if (passwordController.text.trim() != confirmPasswordController.text.trim()
    || passwordController.text.trim().isEmpty || confirmPasswordController.text.trim().isEmpty) {
      showErrorMessage(context, 'Passwords do not match or Empty');
      return;
    } else if (passwordController.text.trim().length < 8) {
      showErrorMessage(context, 'Password must be at least 8 characters');
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    showLoadingDialog(context);
    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (context.mounted) Navigator.pop(context);
    if (success) {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/setUp');
      }
    } else {
      if (context.mounted) {
        showErrorMessage(context, authProvider.errorMessage ?? 'Something went wrong');
      }
    }
  }
}