import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_flutter_appwrite/core/constants/app_write_strings.dart';
import 'package:todo_flutter_appwrite/core/error/exception.dart';
import 'package:todo_flutter_appwrite/core/logger/app_logger.dart';
import 'package:todo_flutter_appwrite/core/provider/app_write_provider.dart';
import 'package:todo_flutter_appwrite/features/auth/data/model/user_model.dart';

abstract interface class AuthAppwriteRemoteSource {
  Future<UserModel> registerUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
}

class AuthAppwriteRemoteSourceImpl implements AuthAppwriteRemoteSource {
  final AppWriteProvider _appWriteProvider;
  final InternetConnectionChecker _internetConnectionChecker;

  AuthAppwriteRemoteSourceImpl({
    required AppWriteProvider appWriteProvider,
    required InternetConnectionChecker internetConnectionChecker,
  }) : _appWriteProvider = appWriteProvider,
       _internetConnectionChecker = internetConnectionChecker;

  @override
  Future<UserModel> registerUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    try {
      if (await _internetConnectionChecker.hasConnection) {
        final response = await _appWriteProvider.account!.create(
          userId: ID.unique(),
          email: email,
          password: password,
          name: '$firstname $lastname',
        );

        await _appWriteProvider.database!.createDocument(
          databaseId: AppWriteStrings.databaseId,
          collectionId: AppWriteStrings.userCollectionId,
          documentId: response.$id,
          data: {
            'id': response.$id,
            'fullname': '$firstname $lastname',
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
            'profileImage': '',
          },
        );

        AppLogger.i('User registered successfully: $response.tolMap()');

        return UserModel.fromMap(response.toMap());
      }
      throw ServerException(message: 'No internet connection');
    } catch (e) {
      AppLogger.e(e.toString());
      throw ServerException(message: '$e');
    }
  }
}
