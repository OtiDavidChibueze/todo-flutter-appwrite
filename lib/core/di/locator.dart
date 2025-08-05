import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../provider/app_write_provider.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/data/source/remote/auth_appwrite_remote_source.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/register_user_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GetIt locator = GetIt.I;

void setUpLocator() {
  locator.registerLazySingleton<AppWriteProvider>(() => AppWriteProvider());

  locator.registerLazySingleton(() => InternetConnectionChecker.I);

  _initAuth();
}

_initAuth() {
  locator
    ..registerLazySingleton<AuthAppwriteRemoteSource>(
      () => AuthAppwriteRemoteSourceImpl(
        appWriteProvider: locator(),
        internetConnectionChecker: locator(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authAppwriteRemoteSource: locator()),
    )
    ..registerFactory(() => RegisterUserUsecase(authRepository: locator()))
    ..registerLazySingleton(() => AuthBloc(registerUserUsecase: locator()));
}
