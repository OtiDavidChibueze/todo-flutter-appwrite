import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import '../repository/auth_repository.dart';

class GetLoggedInUserUseCase extends UseCases<UserEntity?, NoParams> {
  final AuthRepository _authRepository;

  GetLoggedInUserUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams req) async {
    return await _authRepository.getLoggedInUser();
  }
}
