import 'app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final dartThemeMode = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Delius',
    scaffoldBackgroundColor: AppColor.backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: AppColor.appbarColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColor.appColor,
    ),
  );
}
