part of 'todo_bloc.dart';

sealed class TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;

  AddTodoEvent({required this.title, required this.description});
}

final class GetTodosEvent extends TodoEvent {}
