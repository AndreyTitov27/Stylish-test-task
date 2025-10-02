import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylish_test_task/presentation/widgets/stylish_text_field.dart';
import 'package:stylish_test_task/riverpod/auth_provider.dart';
import 'package:stylish_test_task/riverpod/storage_provider.dart';
import 'package:stylish_test_task/styles.dart';
import 'package:stylish_test_task/utils/error_message_util.dart';
import 'package:stylish_test_task/utils/loading_dialog_util.dart';

class SetUpScreen extends ConsumerStatefulWidget {
  const SetUpScreen({super.key});

  @override
  ConsumerState<SetUpScreen> createState() => _SetUpScreenState();
}
class _SetUpScreenState extends ConsumerState<SetUpScreen> {
  final TextEditingController _controller = TextEditingController();

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
            Text('Set up\naccount', style: SignTextStyles.large, textAlign: TextAlign.left),
            StylishTextField(
              controller: _controller,
              placeHolder: 'Enter any text',
              icon: Icons.person,
              onSubmitted: (_) => _onFinishTap(context),
            ),
            CupertinoButton.filled(
              color: Color(0xFFF83758),
              minimumSize: Size(double.infinity, 55.0),
              borderRadius: BorderRadius.circular(4.0),
              onPressed: () => _onFinishTap(context),
              child: Text('Finish', style: SignTextStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _onFinishTap(BuildContext context) async {
    if (_controller.text.trim().isEmpty) {
      showErrorMessage(context, 'Text cannot be empty');
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
      showLoadingDialog(context);
      await ref.read(storageNotifierProvider.notifier)
        .saveText(ref.read(authNotifierProvider).value!.uid, _controller.text.trim());
      if (context.mounted) Navigator.pushReplacementNamed(context, '/home');
    }
  }
}