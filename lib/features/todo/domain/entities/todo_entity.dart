class TodoEntity {
  final String id;
  final String userId;
  final String title;
  final String description;
  final bool isCompleted;

  TodoEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}
