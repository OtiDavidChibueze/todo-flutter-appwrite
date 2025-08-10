import 'package:flutter/material.dart';
import '../theme/app_color.dart';

import '../../utils/size_utils.dart';

class CustomButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final double radius;
  final String btnText;
  final double fontSize;
  final Color textColor;
  final Function() onPressed;

  const CustomButtonWidget({
    super.key,
    this.width = 100,
    this.height = 6,
    this.backgroundColor = AppColor.appColor,
    this.radius = 10,
    required this.btnText,
    this.fontSize = 15,
    this.textColor = AppColor.whiteColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        fixedSize: WidgetStateProperty.all(Size(sw(width), sh(height))),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sr(radius)),
          ),
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(fontSize: sp(fontSize), color: textColor),
      ),
    );
  }
}
