import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/constants/app_string.dart';
import '../../domain/entities/user_entiry.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../source/remote/auth_appwrite_remote_source.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthAppwriteRemoteSource _authAppwriteRemoteSource;

  AuthRepositoryImpl({
    required AuthAppwriteRemoteSource authAppwriteRemoteSource,
  }) : _authAppwriteRemoteSource = authAppwriteRemoteSource;

  @override
  Future<Either<Failure, UserEntity>> registerUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await _authAppwriteRemoteSource.registerUser(
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final data = await fn();

      return Right(data);
    } on AppwriteException catch (e) {
      if (e.message == null) {
        throw ServerException(message: AppString.failure);
      }
      return Left(Failure(e.message!));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
