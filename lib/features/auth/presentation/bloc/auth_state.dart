part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserEntiry user;
  AuthSuccessState({required this.user});
}

final class AuthErrorState extends AuthState {
  final String errorMsg;
  AuthErrorState({required this.errorMsg});
}
