// ignore_for_file: public_member_api_docs, sort_constructors_first
enum TaskStatus { pending, completed, notStarted }

class Task {
  final String id;
  final String title;
  final String description;
  final String subject;
  final DateTime dueDate;
  final TaskStatus status;
  final String? imageUrl;
  final String assignedTo;
  final String? teacherName;
  final String? teacherFeedback;
  final double? progress;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.status,
    this.imageUrl,
    required this.assignedTo,
    this.teacherName,
    this.teacherFeedback,
    this.progress,
  });
}
