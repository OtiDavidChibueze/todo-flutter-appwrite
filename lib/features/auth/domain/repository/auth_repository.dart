import 'package:fpdart/fpdart.dart';
import '../entities/user_entiry.dart';
import '../../../../core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> registerUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
}
