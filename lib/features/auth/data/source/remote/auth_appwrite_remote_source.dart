import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../dtos/register_dto.dart';
import '../../../../../core/constants/app_string.dart';
import '../../model/user_model.dart';
import '../../../../../core/constants/app_write_strings.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/logger/app_logger.dart';
import '../../../../../core/provider/app_write_provider.dart';

abstract interface class AuthAppwriteRemoteSource {
  Future<UserModel> registerUser(RegisterRequestDto user);
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
  Future<UserModel> registerUser(RegisterRequestDto dto) async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: 'No internet connection');
      }

      final account = _appWriteProvider.account;
      final db = _appWriteProvider.database;

      if (account == null) {
        throw ServerException(message: AppString.accountService);
      }

      final createdUser = await account.create(
        userId: ID.unique(),
        email: dto.email,
        password: dto.password,
        name: '${dto.fullname} ${dto.lastname}',
      );

      final document = await db!.createDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.userCollectionId,
        documentId: createdUser.$id,
        data: {
          'id': createdUser.$id,
          'fullname': '${dto.fullname} ${dto.lastname}',
          'firstname': dto.fullname,
          'lastname': dto.lastname,
          'email': dto.email,
          'profileImage': '',
        },
      );

      AppLogger.i('User registered successfully: ${document.toMap()}');
      return UserModel.fromMap(document.data);
    } catch (e) {
      AppLogger.e(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
