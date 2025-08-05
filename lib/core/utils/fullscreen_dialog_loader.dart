import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_flutter_appwrite/core/common/theme/app_color.dart';

class FullscreenDialogLoader {
  static bool _isDialogOpen = false;

  static void show(BuildContext context) {
    if (!_isDialogOpen) {
      _isDialogOpen = true;

      WidgetsBinding.instance.addPersistentFrameCallback((_) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (_) {
              return PopScope(
                canPop: false,
                child: SpinKitCircle(color: AppColor.appColor, size: 50),
              );
            },
          ).then((_) => _isDialogOpen = false);
        }
      });
    }
  }

  static void cancel(BuildContext context) {
    if (_isDialogOpen) {
      Navigator.of(context, rootNavigator: true).pop();

      _isDialogOpen = false;
    }
  }

  static void isDialogCurrentlyOpen() => _isDialogOpen;
}
