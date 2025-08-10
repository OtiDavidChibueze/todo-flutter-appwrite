import 'package:fpdart/fpdart.dart';
import '../../data/dto/edit_todo_request.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import '../entities/todo_entity.dart';
import '../repository/todo_repository.dart';

class EditTodoUsecase implements UseCases<List<TodoEntity>, EditTodoRequest> {
  final TodoRepository _todoRepository;

  EditTodoUsecase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, List<TodoEntity>>> call(EditTodoRequest req) async {
    return await _todoRepository.editTodo(req);
  }
}
