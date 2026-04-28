enum TaskStatus { pending, completed }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final TaskStatus status;
  final String assignedTo;
  final String? teacherId;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.assignedTo,
    this.teacherId,
  });
}