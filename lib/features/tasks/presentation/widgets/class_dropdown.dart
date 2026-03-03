import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/teacher_tasks_notifier.dart';

class ClassDropdown extends ConsumerWidget {
  final String selectedClass;
  final List<String> classes;
  final ValueChanged<String> onChanged;

  const ClassDropdown({
    super.key,
    required this.selectedClass,
    required this.onChanged,
    required this.classes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teacherTasksNotifierProvider);

    /// 👇 الأفضل كمان نجيب classes من state مباشرة
    final classes = state.tasks
        .map((task) => task.assignedTo)
        .toSet()
        .toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Class",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        DropdownButton<String>(
          value: selectedClass.isEmpty && classes.isNotEmpty
              ? classes.first
              : selectedClass,
          items: classes
              .map(
                (className) => DropdownMenuItem(
              value: className,
              child: Text(className),
            ),
          )
              .toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ],
    );
  }
}