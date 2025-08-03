import 'package:flutter/material.dart';
import 'package:todo_flutter_appwrite/core/constants/app_images_url.dart';
import 'package:todo_flutter_appwrite/core/utils/sizer.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // todo navigate to login
      Scaffold(body: Center(child: Text('Splash Page')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImageUrl.logo, width: w(100), height: h(100)),
      ),
    );
  }
}
