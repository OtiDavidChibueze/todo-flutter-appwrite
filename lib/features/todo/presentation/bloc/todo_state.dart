part of 'todo_bloc.dart';

sealed class TodoState {}

final class TodoInitialState extends TodoState {}

final class TodoLoadingState extends TodoState {}

final class TodoSuccessState extends TodoState {
  final List<TodoEntity> todos;

  TodoSuccessState({required this.todos});
}

final class TodoErrorState extends TodoState {
  final String errorMessage;

  TodoErrorState({required this.errorMessage});
}
