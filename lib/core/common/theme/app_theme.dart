import 'app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final dartThemeMode = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColor.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.appbarColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.appColor,
    ),
  );

  static final lightThemeMode = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColor.inverseBackgroundColor,
    appBarTheme: AppBarTheme(color: AppColor.appbarInverse),
  );
}
