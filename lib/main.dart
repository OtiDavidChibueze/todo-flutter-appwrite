import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_flutter_appwrite/core/service/local_storage_service.dart';
import 'app.dart';
import 'core/di/locator.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Hive.initFlutter();
  await LocalStorageService.init();

  setUpLocator();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [BlocProvider(create: (context) => locator<AuthBloc>())],
        child: const MyApp(),
      ),
    ),
  );
}
