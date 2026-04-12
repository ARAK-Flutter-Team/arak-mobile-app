import 'package:flutter/material.dart';
import '../../domain/entities/task_status_entity.dart';
import 'task_status_badge.dart';

class TaskStatusListItem extends StatelessWidget {
  final TaskStatusEntity student;
  final VoidCallback onTap;

  const TaskStatusListItem({
    super.key,
    required this.student,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,

      /// 👤 اسم الطالب
      title: Text(
        student.studentName,
        style: theme.textTheme.bodyLarge,
      ),

      ///  الحالة
      trailing: TaskStatusBadge(
        isDone: student.isDone,
      ),
    );
  }
}