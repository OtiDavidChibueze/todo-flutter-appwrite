import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_flutter_appwrite/core/constants/app_string.dart';
import 'package:todo_flutter_appwrite/core/constants/app_write_strings.dart';
import 'package:todo_flutter_appwrite/core/error/exception.dart';
import 'package:todo_flutter_appwrite/core/logger/app_logger.dart';
import 'package:todo_flutter_appwrite/core/service/app_write_service.dart';
import 'package:todo_flutter_appwrite/core/service/local_storage_service.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/add_todo_request.dart';
import 'package:todo_flutter_appwrite/features/todo/data/model/todo_model.dart';

abstract interface class TodoAppwriteRemoteSource {
  Future<List<TodoModel>> addTodo(AddTodoRequest req);
}

class TodoAppwriteRemoteSourceImpl implements TodoAppwriteRemoteSource {
  final AppWriteService _appWriteService;
  final InternetConnectionChecker _internetConnectionChecker;
  final LocalStorageService _localStorageService;

  TodoAppwriteRemoteSourceImpl({
    required AppWriteService appWriteService,
    required InternetConnectionChecker internetConnectionChecker,
    required LocalStorageService localStorageService,
  }) : _appWriteService = appWriteService,
       _internetConnectionChecker = internetConnectionChecker,
       _localStorageService = localStorageService;

  @override
  Future<List<TodoModel>> addTodo(AddTodoRequest req) async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      final documentId = ID.unique();

      final addDocument = await db.createDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.todoCollectionId,
        documentId: documentId,
        data: {
          'id': documentId,
          'userId': _localStorageService.getSession(AppString.userId),
          'title': req.title,
          "description": req.description,
          'isCompleted': false,
        },
      );

      AppLogger.i('Saved Todo: ${addDocument.toMap()}');

      final getTodos = await db.listDocuments(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.todoCollectionId,
        queries: [
          Query.equal(
            'userId',
            _localStorageService.getSession(AppString.userId),
          ),
        ],
      );

      AppLogger.i('Fetched Todos: ${getTodos.toMap()}');

      return getTodos.documents
          .map((doc) => TodoModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      AppLogger.e('Add todo Error: $e');
      throw ServerException(message: e.toString());
    }
  }
}
