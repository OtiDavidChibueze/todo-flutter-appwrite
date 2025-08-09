import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/exception.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/add_todo_request.dart';
import 'package:todo_flutter_appwrite/features/todo/data/source/remote/todo_appwrite_remote_source.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoAppwriteRemoteSource _todoAppwriteRemoteSource;

  TodoRepositoryImpl({
    required TodoAppwriteRemoteSource todoAppwriteRemoteSource,
  }) : _todoAppwriteRemoteSource = todoAppwriteRemoteSource;

  @override
  Future<Either<Failure, List<TodoEntity>>> addTodo(AddTodoRequest req) {
    return _getTodo(() async => await _todoAppwriteRemoteSource.addTodo(req));
  }

  Future<Either<Failure, List<TodoEntity>>> _getTodo(
    Future<List<TodoEntity>> Function() fn,
  ) async {
    try {
      final todo = await fn();

      return Right(todo);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
