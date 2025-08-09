import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/add_todo_request.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/entities/todo_entity.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> addTodo(AddTodoRequest req);
}
