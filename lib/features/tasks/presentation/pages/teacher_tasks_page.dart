import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/teacher_classes_provider.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/task_item_card.dart';
import '../widgets/add_task_button.dart';
import '../widgets/loading_view.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';

class TeacherTasksScreen extends ConsumerStatefulWidget {
  final String teacherId;
  const TeacherTasksScreen({Key? key, required this.teacherId}) : super(key: key);

  @override
  ConsumerState<TeacherTasksScreen> createState() => _TeacherTasksScreenState();
}

class _TeacherTasksScreenState extends ConsumerState<TeacherTasksScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(teacherTasksNotifierProvider.notifier).loadSavedTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(teacherClassesProvider(widget.teacherId));
    final state = ref.watch(teacherTasksNotifierProvider);
    final notifier = ref.read(teacherTasksNotifierProvider.notifier);

    return Scaffold(
      appBar: AppMainAppBar(
        title:AppLocalizations.of(context)!.tasks,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // Class Dropdown
              classesAsync.when(
                loading: () => const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                error: (e, _) => Center(
                  child: Text(
                    "Error loading classes",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                data: (classes) {
                  if (classes.isEmpty) return const SizedBox();

                  if (state.selectedClass.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      notifier.changeClass(
                        teacherId: widget.teacherId,
                        newClassId: classes.first,
                      );
                    });
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.selectClass,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      AppDropdown(
                        selectedClass: state.selectedClass,
                        classes: classes,
                        onChanged: (newClass) {
                          notifier.changeClass(
                            teacherId: widget.teacherId,
                            newClassId: newClass,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // Tasks List
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state.isLoading) return const LoadingView();
                    if (state.error != null) return ErrorView(message: state.error!);
                    if (state.tasks.isEmpty) return const EmptyView();

                    return ListView.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        return TaskItemCard(task: state.tasks[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AddTaskButton(
          onPressed: () {
            context.push(
              '/teacher/add-task',
              extra: widget.teacherId,
            );
          },
        ),
      ),
    );
  }
}