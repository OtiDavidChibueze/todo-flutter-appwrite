import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../../core/constants/app_string.dart';
import '../../model/user_model.dart';
import '../../../../../core/constants/app_write_strings.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/logger/app_logger.dart';
import '../../../../../core/provider/app_write_provider.dart';

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
        if (_appWriteProvider.account == null) {
          throw ServerException(message: AppString.accountService);
        }
        final user = await _appWriteProvider.account!.create(
          userId: ID.unique(),
          email: email,
          password: password,
          name: '$firstname $lastname',
        );

        final userDoc = await _appWriteProvider.database!.createDocument(
          databaseId: AppWriteStrings.databaseId,
          collectionId: AppWriteStrings.userCollectionId,
          documentId: user.$id,
          data: {
            'id': user.$id,
            'fullname': '$firstname $lastname',
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
            'profileImage': '',
          },
        );

        AppLogger.i(
          'User registered successfully -> UserData:${userDoc.data},\n UserMetaData: ${userDoc.toMap()}',
        );

        return UserModel.fromMap(userDoc.data);
      }
      throw ServerException(message: 'No internet connection');
    } catch (e) {
      AppLogger.e(e.toString());
      throw ServerException(message: '$e');
    }
  }
}
