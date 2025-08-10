import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/delete_todo_request.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/usecases/delete_todo_usecase.dart';
import '../../data/dto/edit_todo_request.dart';
import '../../domain/usecases/edit_todo_usecase.dart';
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
  final EditTodoUsecase _editTodoUsecase;
  final DeleteTodoUsecase _deleteTodoUsecase;

  TodoBloc({
    required AddTodoUsecase addTodoUsecase,
    required GetTodosUsecase getTodosUsecase,
    required EditTodoUsecase editTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
  }) : _addTodoUsecase = addTodoUsecase,
       _getTodosUsecase = getTodosUsecase,
       _editTodoUsecase = editTodoUsecase,
       _deleteTodoUsecase = deleteTodoUsecase,

       super(TodoInitialState()) {
    on<TodoEvent>((event, emit) => emit(TodoLoadingState()));
    on<AddTodoEvent>(_onAddTodoEvent);
    on<GetTodosEvent>(_onGetTodosEvent);
    on<EditTodoEvent>(_onEditTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
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

  Future<void> _onEditTodoEvent(
    EditTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await _editTodoUsecase(
      EditTodoRequest(
        todoId: event.todoId,
        title: event.title,
        description: event.description,
        isCompleted: event.isCompleted,
      ),
    );

    result.fold(
      (l) => emit(TodoErrorState(errorMessage: l.message)),
      (r) => emit(TodoSuccessState(todos: r)),
    );
  }

  Future<void> _onDeleteTodoEvent(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await _deleteTodoUsecase(
      DeleteTodoRequest(todoId: event.todoId),
    );

    result.fold(
      (l) => emit(TodoErrorState(errorMessage: l.message)),
      (r) => emit(TodoSuccessState(todos: r)),
    );
  }
}
