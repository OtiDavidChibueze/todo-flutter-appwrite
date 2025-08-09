import 'package:flutter/material.dart';

import '../../../../core/constants/app_images_url.dart';
import '../../../../core/utils/size_utils.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = 'splash';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImageUrl.logo, width: w(100), height: h(100)),
      ),
    );
  }
}
