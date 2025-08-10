import 'package:fpdart/fpdart.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/delete_todo_request.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import '../entities/todo_entity.dart';
import '../repository/todo_repository.dart';

class DeleteTodoUsecase
    implements UseCases<List<TodoEntity>, DeleteTodoRequest> {
  final TodoRepository _todoRepository;

  DeleteTodoUsecase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, List<TodoEntity>>> call(DeleteTodoRequest req) async {
    return await _todoRepository.deleteTodo(req);
  }
}
