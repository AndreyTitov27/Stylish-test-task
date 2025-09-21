import 'package:flutter/material.dart';

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16.0),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(32.0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              child: Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Color(0xFFF83758)),
                  constraints: BoxConstraints(
                    minWidth: 64.0,
                    minHeight: 64.0,
                  ),
                  strokeCap: StrokeCap.round,
                  strokeWidth: 4.0,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}