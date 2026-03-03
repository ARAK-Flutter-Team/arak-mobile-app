enum TaskStatus { pending, completed }

class Task {
  final String id;
  final String title;
  final String description;
  final String subject;
  final DateTime dueDate;
  final TaskStatus status;
  final String? imageUrl;
  final String assignedTo;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.status,
    this.imageUrl,
    required this.assignedTo,
  });
}