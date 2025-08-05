part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthRegisterEvent extends AuthEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  AuthRegisterEvent({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}
