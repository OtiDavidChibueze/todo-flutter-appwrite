import 'package:appwrite/appwrite.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/delete_todo_request.dart';
import '../../dto/edit_todo_request.dart';
import '../../../../../core/constants/app_string.dart';
import '../../../../../core/constants/app_write_strings.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/logger/app_logger.dart';
import '../../../../../core/service/app_write_service.dart';
import '../../../../../core/service/local_storage_service.dart';
import '../../dto/add_todo_request.dart';
import '../../model/todo_model.dart';

abstract interface class TodoAppwriteRemoteSource {
  Future<List<TodoModel>> addTodo(AddTodoRequest req);
  Future<List<TodoModel>> getTodos();
  Future<List<TodoModel>> editTodos(EditTodoRequest req);
  Future<List<TodoModel>> deleteTodo(DeleteTodoRequest req);
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

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      final loggedInUserId = _localStorageService.getSession(AppString.userId);

      if (loggedInUserId == null) {
        throw ServerException(message: AppString.noActiveSession);
      }

      final getTodos = await db.listDocuments(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.todoCollectionId,
        queries: [Query.equal('userId', loggedInUserId)],
      );

      AppLogger.i('Fetch Todos: ${getTodos.toMap()}');

      return getTodos.documents
          .map((doc) => TodoModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      AppLogger.e('Get todos Error: $e');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<TodoModel>> editTodos(EditTodoRequest req) async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      final loggedInUserId = _localStorageService.getSession(AppString.userId);

      if (loggedInUserId == null) {
        throw ServerException(message: AppString.noActiveSession);
      }

      final updateTodo = await db.updateDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.todoCollectionId,
        documentId: req.todoId,
        data: {
          'title': req.title,
          'description': req.description,
          'isCompleted': req.isCompleted,
        },
      );

      AppLogger.i('update Todo: ${updateTodo.toMap()}');

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

      return getTodos.documents
          .map((doc) => TodoModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      AppLogger.e('Get todos Error: $e');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<TodoModel>> deleteTodo(DeleteTodoRequest req) async {
    try {
      if (!await _internetConnectionChecker.hasConnection) {
        throw ServerException(message: AppString.internetConnection);
      }

      final account = _appWriteService.account;
      final db = _appWriteService.database;

      if (account == null || db == null) {
        throw ServerException(message: AppString.account_database);
      }

      await db.deleteDocument(
        databaseId: AppWriteStrings.databaseId,
        collectionId: AppWriteStrings.todoCollectionId,
        documentId: req.todoId,
      );

      AppLogger.i('deleted Todo');

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

      return getTodos.documents
          .map((doc) => TodoModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      AppLogger.e('Delete todo Error: $e');
      throw ServerException(message: e.toString());
    }
  }
}
