import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/core/usecases/use_cases.dart';
import 'package:todo_flutter_appwrite/features/auth/data/dtos/edit_profile.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/entities/user_entity.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/repository/auth_repository.dart';

class EditProfileUseCase implements UseCases<UserEntity, EditProfileRequest> {
  final AuthRepository _authRepository;

  EditProfileUseCase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(EditProfileRequest req) async {
    return await _authRepository.editProfile(req);
  }
}
