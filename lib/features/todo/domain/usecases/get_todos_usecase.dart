import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_cases.dart';
import '../entities/todo_entity.dart';
import '../repository/todo_repository.dart';

class GetTodosUsecase implements UseCases<List<TodoEntity>, NoParams> {
  final TodoRepository _todoRepository;

  GetTodosUsecase({required TodoRepository todoRepository})
    : _todoRepository = todoRepository;

  @override
  Future<Either<Failure, List<TodoEntity>>> call(NoParams req) async {
    return await _todoRepository.getTodos();
  }
}
