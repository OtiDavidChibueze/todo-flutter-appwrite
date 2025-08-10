import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../data/dto/add_todo_request.dart';
import '../entities/todo_entity.dart';

abstract interface class TodoRepository {
  Future<Either<Failure, List<TodoEntity>>> addTodo(AddTodoRequest req);
  Future<Either<Failure, List<TodoEntity>>> getTodos();
}
