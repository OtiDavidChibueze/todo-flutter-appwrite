import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_flutter_appwrite/features/auth/data/dtos/edit_profile.dart';
import '../../../../../core/constants/app_string.dart';
import '../../../../../core/constants/app_write_strings.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/logger/app_logger.dart';
import '../../../../../core/service/app_write_service.dart';
import '../../../../../core/service/local_storage_service.dart';
import '../../dtos/login_dto.dart';
import '../../dtos/register_dto.dart';
import '../../model/user_model.dart';

abstract class AuthAppwriteRemoteSource {
  Future<UserModel> registerUser(RegisterRequestDto req);
  Future<UserModel> loginUser(LoginRequestDto req);
  Future<UserModel?> getLoggedInUser();
  Future<UserModel> editProfile(EditProfileRequest req);
}

class AuthAppwriteRemoteSourceImpl implements AuthAppwriteRemoteSource {
  final AppWriteService _appWriteService;
  final InternetConnectionChecker _internetConnectionChecker;
  final LocalStorageService _localStorageService;

  AuthAppwriteRemoteSourceImpl({
    required AppWriteService appWriteService,
    required InternetConnectionChecker internetConnectionChecker,
    required LocalStorageService localStorageService,
  }) : _appWriteService = appWriteService,
       _internetConnectionChecker = internetConnectionChecker,
       _localStorageService = localStorageService;

  @override
  Future<UserModel> registerUser(RegisterRequestDto req) async {
    try {
      // Internet check
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      // Create Appwrite account
      final createdUser = await account.create(
        userId: ID.unique(),
        email: req.email,
        password: req.password,
        name: '${req.firstname} ${req.lastname}',
      );

      // Create user document in DB
      final document = await db.createDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.userCollectionId,
        documentId: createdUser.$id,
        data: {
          'id': createdUser.$id,
          'fullname': '${req.firstname} ${req.lastname}',
          'firstname': req.firstname,
          'lastname': req.lastname,
          'email': req.email,
          'profileImage': 'user.png',
        },
      );

      AppLogger.i('User registered successfully: ${document.toMap()}');
      return UserModel.fromMap(document.data);
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        throw ServerException(message: AppString.emailUsed);
      }
      rethrow;
    } catch (e) {
      AppLogger.e('Registration error: $e');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> loginUser(LoginRequestDto req) async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      final session = await account.createEmailPasswordSession(
        email: req.email,
        password: req.password,
      );

      await _localStorageService.saveSession(AppString.sessionKey, session.$id);
      await _localStorageService.saveSession(AppString.userId, session.userId);

      AppLogger.i('User logged in: ${session.toMap()}');

      final userDoc = await db.getDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.userCollectionId,
        documentId: session.userId,
      );

      return UserModel.fromMap(userDoc.data);
    } catch (e) {
      AppLogger.e('Login error: $e');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getLoggedInUser() async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      final savedSessionId = _localStorageService.getSession(
        AppString.sessionKey,
      );

      if (savedSessionId == null) {
        AppLogger.w(AppString.noSessionFound);
        return null;
      }

      Session session;
      try {
        session = await account.getSession(sessionId: savedSessionId);
      } on AppwriteException catch (e) {
        if (e.code == 401) {
          AppLogger.w(AppString.sessionExpired);
          await _localStorageService.deleteSession(AppString.sessionKey);
          return null;
        }
        rethrow;
      }

      final userDoc = await db.getDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.userCollectionId,
        documentId: session.userId,
      );

      AppLogger.i('Fetched logged in user: ${userDoc.toMap()}');

      return UserModel.fromMap(userDoc.data);
    } catch (e) {
      AppLogger.e('Error getting logged-in user: $e');
      return null;
    }
  }

  @override
  Future<UserModel> editProfile(EditProfileRequest req) async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      final loggedInUser = _localStorageService.getSession(AppString.userId);

      if (loggedInUser == null) {
        throw ServerException(message: AppString.noActiveSession);
      }

      final updateUser = await db.updateDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.userCollectionId,
        documentId: loggedInUser,
        data: {
          'firstname': req.firstname,
          'lastname': req.lastname,
          'profileImage': req.profileImage,
        },
      );

      AppLogger.i('Updated user: ${updateUser.toMap()}');

      return UserModel.fromMap(updateUser.data);
    } catch (e) {
      AppLogger.e('Error getting logged-in user: $e');
      throw ServerException(message: e.toString());
    }
  }
}
