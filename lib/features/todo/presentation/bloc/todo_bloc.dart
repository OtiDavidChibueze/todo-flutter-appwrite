import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter_appwrite/features/todo/data/dto/add_todo_request.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_flutter_appwrite/features/todo/domain/usecases/add_todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoUsecase _addTodoUsecase;

  TodoBloc({required AddTodoUsecase addTodoUsecase})
    : _addTodoUsecase = addTodoUsecase,
      super(TodoInitialState()) {
    on<TodoEvent>((event, emit) {});
    on<AddTodoEvent>(_onAddTodoEvent);
  }

  Future<void> _onAddTodoEvent(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoadingState());

    final result = await _addTodoUsecase(
      AddTodoRequest(title: event.title, description: event.description),
    );

    result.fold(
      (l) => emit(TodoErrorState(errorMessage: l.message)),
      (r) => emit(TodoSuccessState(todos: r)),
    );
  }
}
