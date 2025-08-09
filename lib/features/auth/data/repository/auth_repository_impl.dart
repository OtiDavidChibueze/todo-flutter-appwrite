import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/user_entity.dart';

import '../dtos/login_dto.dart';
import '../dtos/register_dto.dart';
import '../../../../core/constants/app_string.dart';
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
  Future<Either<Failure, UserEntity>> registerUser(
    RegisterRequestDto req,
  ) async {
    return _getUser(() => _authAppwriteRemoteSource.registerUser(req));
  }

  @override
  Future<Either<Failure, UserEntity>> loginUser(LoginRequestDto req) async {
    return _getUser(() => _authAppwriteRemoteSource.loginUser(req));
  }

  @override
  Future<Either<Failure, UserEntity>> getLoggedInUser() async {
    try {
      final user = await _authAppwriteRemoteSource.getLoggedInUser();

      if (user == null) {
        return Left(Failure(AppString.noActiveSession));
      }

      return Right(user);
    } on AppwriteException catch (e) {
      return Left(Failure(e.message ?? AppString.failure));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (_) {
      return Left(Failure(AppString.failure));
    }
  }

  // Generic wrapper for calling remote source methods
  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      final data = await fn();
      return Right(data);
    } on AppwriteException catch (e) {
      return Left(Failure(e.message ?? AppString.failure));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (_) {
      return Left(Failure(AppString.failure));
    }
  }
}
