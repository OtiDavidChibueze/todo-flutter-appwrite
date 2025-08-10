import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/usecases/edit_profile.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/usecases/delete_todo_usecase.dart';
import '../../features/todo/domain/usecases/edit_todo_usecase.dart';
import '../../features/todo/data/repository/todo_repository_impl.dart';
import '../../features/todo/data/source/remote/todo_appwrite_remote_source.dart';
import '../../features/todo/domain/repository/todo_repository.dart';
import '../../features/todo/domain/usecases/add_todo_usecase.dart';
import '../../features/todo/domain/usecases/get_todos_usecase.dart';
import '../../features/todo/presentation/bloc/todo_bloc.dart';
import '../../features/auth/domain/usecases/get_logged_in_user.dart';
import '../service/local_storage_service.dart';
import '../../features/auth/domain/usecases/login_user_usecase.dart';
import '../service/app_write_service.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/data/source/remote/auth_appwrite_remote_source.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/register_user_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GetIt locator = GetIt.I;

void setUpLocator() async {
  locator.registerLazySingleton(() => AppWriteService());

  locator.registerLazySingleton(() => InternetConnectionChecker.I);

  _initAuth();

  locator.registerLazySingleton(() => LocalStorageService());

  _initTodo();
}

_initAuth() {
  locator
    ..registerLazySingleton<AuthAppwriteRemoteSource>(
      () => AuthAppwriteRemoteSourceImpl(
        appWriteService: locator(),
        internetConnectionChecker: locator(),
        localStorageService: locator(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authAppwriteRemoteSource: locator()),
    )
    ..registerFactory(() => RegisterUserUsecase(authRepository: locator()))
    ..registerFactory(() => LoginUserUseCase(authRepository: locator()))
    ..registerFactory(() => GetLoggedInUserUseCase(authRepository: locator()))
    ..registerFactory(() => EditProfileUseCase(authRepository: locator()))
    ..registerLazySingleton(
      () => AuthBloc(
        registerUserUsecase: locator(),
        loginUserUseCase: locator(),
        getLoggedInUser: locator(),
        editProfileUseCase: locator(),
      ),
    );
}

_initTodo() {
  locator
    ..registerLazySingleton<TodoAppwriteRemoteSource>(
      () => TodoAppwriteRemoteSourceImpl(
        appWriteService: locator(),
        internetConnectionChecker: locator(),
        localStorageService: locator(),
      ),
    )
    ..registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(todoAppwriteRemoteSource: locator()),
    )
    ..registerFactory(() => AddTodoUsecase(todoRepository: locator()))
    ..registerFactory(() => GetTodosUsecase(todoRepository: locator()))
    ..registerFactory(() => EditTodoUsecase(todoRepository: locator()))
    ..registerFactory(() => DeleteTodoUsecase(todoRepository: locator()))
    ..registerLazySingleton(
      () => TodoBloc(
        addTodoUsecase: locator(),
        getTodosUsecase: locator(),
        editTodoUsecase: locator(),
        deleteTodoUsecase: locator(),
      ),
    );
}
