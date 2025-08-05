import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/entities/user_entiry.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntiry>> registerUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
}
