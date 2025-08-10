class EditTodoRequest {
  final String todoId;
  final String title;
  final String description;
  final bool isCompleted;

  EditTodoRequest({
    required this.todoId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todoId': todoId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }
}
