import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_flutter_appwrite/app.dart';
import 'package:todo_flutter_appwrite/core/di/locator.dart';
import 'package:todo_flutter_appwrite/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

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
