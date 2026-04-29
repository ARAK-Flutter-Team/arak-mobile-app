import 'package:flutter/material.dart';
import '../../../tasks/domain/entities/task_student_status.dart';
import 'task_status_list_item.dart';

class TaskStatusList extends StatelessWidget {
  final List<TaskStudentStatus> students;
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
          studentId: student.studentId,
          studentName: student.studentName,
          isDone: student.isDone,
          onTap: () => onToggle(student.studentId),
        );
      },
    );
  }
}