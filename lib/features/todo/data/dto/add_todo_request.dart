class AddTodoRequest {
  final String title;
  final String description;

  AddTodoRequest({required this.title, required this.description});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'description': description};
  }
}
