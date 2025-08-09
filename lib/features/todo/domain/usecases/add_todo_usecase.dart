import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/core/error/failure.dart';
import 'package:todo_flutter_appwrite/core/usecases/use_cases.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/add_todo_request.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/repository/todo_repository.dart';

class AddTodoUsecase implements UseCases<List<TodoEntity>, AddTodoRequest> {
  final TodoRepository _todoRepository;

  AddTodoUsecase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, List<TodoEntity>>> call(AddTodoRequest req) async {
    return await _todoRepository.addTodo(req);
  }
}
