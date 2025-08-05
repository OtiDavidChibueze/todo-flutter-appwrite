import 'package:flutter/material.dart';
import '../common/theme/app_color.dart';
import 'size_utils.dart';

class CustomSnackbar {
  static void error(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackbarRed);
  }

  static void success(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackbarGreen);
  }

  static void info(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackbarBlue);
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: color,
            content: Text(
              message,
              style: TextStyle(fontSize: sp(14), color: AppColor.whiteColor),
            ),
          ),
        );
    });
  }
}
