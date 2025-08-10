part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;

  AddTodoEvent({required this.title, required this.description});
}

final class GetTodosEvent extends TodoEvent {}

final class EditTodoEvent extends TodoEvent {
  final String todoId;
  final String title;
  final String description;
  final bool isCompleted;

  EditTodoEvent({
    required this.todoId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
