import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../domain/usecases/get_logged_in_user.dart';
import '../../data/dtos/login_dto.dart';
import '../../domain/usecases/login_user_usecase.dart';
import '../../data/dtos/register_dto.dart';
import '../../domain/usecases/register_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserUsecase _registerUserUsecase;
  final LoginUserUseCase _loginUserUseCase;
  final GetLoggedInUserUseCase _getLoggedInUserUseCase;

  AuthBloc({
    required RegisterUserUsecase registerUserUsecase,
    required LoginUserUseCase loginUserUseCase,
    required GetLoggedInUserUseCase getLoggedInUser,
  }) : _registerUserUsecase = registerUserUsecase,
       _loginUserUseCase = loginUserUseCase,
       _getLoggedInUserUseCase = getLoggedInUser,
       super(AuthInitialState()) {
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthRegisterEvent>(_onAuthRegisterEvent);
    on<AuthLoginEvent>(_onAuthLoginEvent);
    on<AuthGetLoggedInUser>(_onAuthGetLoggedInUser);
  }

  Future<void> _onAuthRegisterEvent(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _registerUserUsecase(
      RegisterRequestDto(
        firstname: event.firstname,
        lastname: event.lastname,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (l) => emit(AuthErrorState(errorMsg: l.message)),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }

  Future<void> _onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _loginUserUseCase(
      LoginRequestDto(email: event.email, password: event.password),
    );

    result.fold(
      (l) => emit(AuthErrorState(errorMsg: l.message)),
      (r) => emit(AuthSuccessState(user: r)),
    );
  }

  Future<void> _onAuthGetLoggedInUser(
    AuthGetLoggedInUser event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getLoggedInUserUseCase(NoParams());

    result.fold(
      (l) => emit(AuthErrorState(errorMsg: l.message)),
      (r) => emit(AuthSuccessState(user: r!)),
    );
  }
}
