import '../constants/app_string.dart';

class Failure {
  final String message;
  Failure([this.message = AppString.failure]);

  @override
  String toString() => message;
}
