import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/add_task_button.dart';
import '../widgets/class_dropdown.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/last_update_text.dart';
import '../widgets/loading_view.dart';
import '../widgets/tasks_container.dart';

class TeacherTasksScreen extends ConsumerWidget {
  final String teacherId;
  final List<String> classes;

  const TeacherTasksScreen({
    super.key,
    required this.teacherId,
    required this.classes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teacherTasksNotifierProvider);
    final notifier = ref.read(teacherTasksNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppMainAppBar(
        title: "Tasks",
        showBackButton: true,
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              /// 🔹 Class Dropdown
              ClassDropdown(
                selectedClass: state.selectedClass,
                classes: classes,
                onChanged: (newClass) {
                  notifier.changeClass(
                    teacherId: teacherId,
                    newClassId: newClass,
                  );
                },
              ),

              const SizedBox(height: 20),

              /// 🔹 Body State Switcher
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state.isLoading) {
                      return const LoadingView();
                    }

                    if (state.error != null) {
                      return ErrorView(message: state.error!);
                    }

                    if (state.tasks.isEmpty) {
                      return const EmptyView();
                    }

                    return TasksContainer(tasks: state.tasks);
                  },
                ),
              ),

              const SizedBox(height: 12),

              /// 🔹 Last Update
              const LastUpdateText(),

              const SizedBox(height: 20),

              /// 🔹 Add Task Button
              AddTaskButton(
                onPressed: () {
                  context.go('/add-task');
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}