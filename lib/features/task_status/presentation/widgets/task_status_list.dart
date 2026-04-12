import 'package:flutter/material.dart';
import '../../domain/entities/task_status_entity.dart';
import 'task_status_list_item.dart';

class TaskStatusList extends StatelessWidget {
  final List<TaskStatusEntity> students;
  final Function(String studentId) onToggle;

  const TaskStatusList({
    super.key,
    required this.students,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: students.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        final student = students[index];

        return TaskStatusListItem(
          student: student,
          onTap: () => onToggle(student.studentId),
        );
      },
    );
  }
}