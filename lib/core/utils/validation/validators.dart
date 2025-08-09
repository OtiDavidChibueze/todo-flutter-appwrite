import '../../constants/app_string.dart';

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

    if (value.length <= 8 || value.length >= 265) {
      return AppString.passwordValidation;
    }

    return null;
  }
}
