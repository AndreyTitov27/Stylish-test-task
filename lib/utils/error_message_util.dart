import 'package:flutter/material.dart';
import 'package:stylish_test_task/styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

void showErrorMessage(BuildContext context, String errorMessage) {
  showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(
      message: errorMessage,
      textStyle: SignTextStyles.buttonText,
      textScaleFactor: 0.85,
    ),
    animationDuration: Duration(milliseconds: 900),
    displayDuration: Duration(seconds: 1),
  );
}