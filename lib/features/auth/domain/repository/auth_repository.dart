import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../data/dtos/register_dto.dart';
import '../entities/user_entiry.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> registerUser(RegisterRequestDto user);
}
