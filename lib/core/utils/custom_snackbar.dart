import 'package:flutter/material.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';

class CustomSnackbar {
  static void showError(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackbarRed);
  }

  static void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackbarBlue);
  }

  static void showSuccess(BuildContext context, String message) {
    _showSnackBar(context, message, AppColor.snackbarGreen);
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message), backgroundColor: color),
        );
    });
  }
}
