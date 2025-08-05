import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/core/usecases/use_cases.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/entities/user_entiry.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/repository/auth_repository.dart';

class RegisterUserUsecase implements UseCases<UserEntiry, RegisterUserParams> {
  final AuthRepository _authRepository;

  RegisterUserUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntiry>> call(RegisterUserParams params) async {
    return await _authRepository.registerUser(
      firstname: params.firstname,
      lastname: params.lastname,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterUserParams {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  RegisterUserParams({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}
