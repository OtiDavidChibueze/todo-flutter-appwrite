import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/exception.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/features/auth/data/source/remote/auth_appwrite_remote_source.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/entities/user_entiry.dart';
import 'package:todo_flutter_appwrite/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthAppwriteRemoteSource _authAppwriteRemoteSource;

  AuthRepositoryImpl({
    required AuthAppwriteRemoteSource authAppwriteRemoteSource,
  }) : _authAppwriteRemoteSource = authAppwriteRemoteSource;

  @override
  Future<Either<Failure, UserEntiry>> registerUser({
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

  Future<Either<Failure, UserEntiry>> _getUser(
    Future<UserEntiry> Function() fn,
  ) async {
    try {
      final data = await fn();

      return Right(data);
    } on AppwriteException catch (e) {
      return Left(Failure(e.message!));
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
