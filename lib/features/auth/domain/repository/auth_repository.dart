import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/features/auth/data/dtos/edit_profile.dart';

import '../entities/user_entity.dart';
import '../../data/dtos/login_dto.dart';
import '../../../../core/error/failure.dart';
import '../../data/dtos/register_dto.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> registerUser(RegisterRequestDto req);
  Future<Either<Failure, UserEntity>> loginUser(LoginRequestDto req);
  Future<Either<Failure, UserEntity>> getLoggedInUser();
  Future<Either<Failure, UserEntity>> editProfile(EditProfileRequest req);
}
