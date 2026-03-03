/*import 'package:flutter/material.dart';
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
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_colors.dart';

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
    // 👇 لو مفيش كلاسات أصلاً
    if (classes.isEmpty) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Select Class",
          style: Theme.of(context).textTheme.titleMedium,
        ),

        SizedBox(
          width: 120,
          child: DropdownButtonFormField<String>(
            value: selectedClass.isEmpty
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
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface(context), // 🤍 أبيض / 🖤 أسود

              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.strokeColor,
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.strokeColor,
                  width: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}