import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/use_cases.dart';
import '../../data/dto/add_todo_request.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/add_todo_usecase.dart';
import '../../domain/usecases/get_todos_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoUsecase _addTodoUsecase;
  final GetTodosUsecase _getTodosUsecase;

  TodoBloc({
    required AddTodoUsecase addTodoUsecase,
    required GetTodosUsecase getTodosUsecase,
  }) : _addTodoUsecase = addTodoUsecase,
       _getTodosUsecase = getTodosUsecase,

       super(TodoInitialState()) {
    on<TodoEvent>((event, emit) => emit(TodoLoadingState()));
    on<AddTodoEvent>(_onAddTodoEvent);
    on<GetTodosEvent>(_onGetTodosEvent);
  }

  Future<void> _onAddTodoEvent(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await _addTodoUsecase(
      AddTodoRequest(title: event.title, description: event.description),
    );

    result.fold(
      (l) => emit(TodoErrorState(errorMessage: l.message)),
      (r) => emit(TodoSuccessState(todos: r)),
    );
  }

  Future<void> _onGetTodosEvent(
    GetTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await _getTodosUsecase(NoParams());

    result.fold(
      (l) => emit(TodoErrorState(errorMessage: l.message)),
      (r) => emit(TodoSuccessState(todos: r)),
    );
  }
}
