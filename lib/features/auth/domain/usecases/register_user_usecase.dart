import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../data/dtos/register_dto.dart';
import '../entities/user_entiry.dart';
import '../repository/auth_repository.dart';

class RegisterUserUsecase implements UseCases<UserEntity, RegisterRequestDto> {
  final AuthRepository _authRepository;

  RegisterUserUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(RegisterRequestDto params) async {
    return _authRepository.registerUser(params);
  }
}
