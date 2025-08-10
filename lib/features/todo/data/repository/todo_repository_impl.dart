import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/delete_todo_request.dart';
import '../dto/edit_todo_request.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../dto/add_todo_request.dart';
import '../source/remote/todo_appwrite_remote_source.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/repository/todo_repository.dart';

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

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodos() {
    return _getTodo(() async => await _todoAppwriteRemoteSource.getTodos());
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> editTodo(EditTodoRequest req) {
    return _getTodo(() async => await _todoAppwriteRemoteSource.editTodos(req));
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> deleteTodo(DeleteTodoRequest req) {
    return _getTodo(
      () async => await _todoAppwriteRemoteSource.deleteTodo(req),
    );
  }
}
