import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entiry.dart';
import '../../domain/usecases/register_user_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserUsecase _registerUserUsecase;

  AuthBloc({required RegisterUserUsecase registerUserUsecase})
    : _registerUserUsecase = registerUserUsecase,
      super(AuthInitialState()) {
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthRegisterEvent>(_onAuthRegisterEvent);
  }

  Future<void> _onAuthRegisterEvent(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _registerUserUsecase(
      RegisterUserParams(
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
}
