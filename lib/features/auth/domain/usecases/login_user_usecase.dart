import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../data/dtos/login_dto.dart';
import '../repository/auth_repository.dart';

class LoginUserUseCase extends UseCases<UserEntity, LoginRequestDto> {
  final AuthRepository _authRepository;

  LoginUserUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginRequestDto req) async {
    return await _authRepository.loginUser(req);
  }
}
