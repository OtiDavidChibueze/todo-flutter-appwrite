import 'package:todo_flutter_appwrite/core/constants/app_string.dart';

class Validations {
  static String? isEmpty(String? value) {
    if (value == null || value.isEmpty) return AppString.required;
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return AppString.required;

    final pattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!pattern.hasMatch(value)) return AppString.emailValidation;
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return AppString.required;

    if (value.length <= 5) return AppString.passwordTooShort;

    return null;
  }
}
