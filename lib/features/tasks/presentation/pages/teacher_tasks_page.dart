import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/teacher_classes_provider.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/add_task_button.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/last_update_text.dart';
import '../widgets/loading_view.dart';
import '../widgets/task_item_card.dart';

class TeacherTasksScreen extends ConsumerStatefulWidget {
  final String teacherId;

  const TeacherTasksScreen({
    super.key,
    required this.teacherId,
  });

  @override
  ConsumerState<TeacherTasksScreen> createState() => _TeacherTasksScreenState();
}

class _TeacherTasksScreenState extends ConsumerState<TeacherTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final classesAsync = ref.watch(teacherClassesProvider(widget.teacherId));

    final state = ref.watch(teacherTasksNotifierProvider);
    final notifier = ref.read(teacherTasksNotifierProvider.notifier);

    return Scaffold(
      appBar: AppMainAppBar(
        title: "Tasks",
        showBackButton: true,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: SvgPicture.asset(
              'assets/icons/file-search-alt.svg',
              width: 25.w,
              height: 25.h,
              colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color ??
                    Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                /// ✅ Dropdown مربوط بالـ provider
                classesAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => const Text("Error loading classes"),
                  data: (classes) {
                    if (classes.isEmpty) {
                      return const SizedBox();
                    }

                    if ((state.selectedClass.isEmpty)) {
                      Future.microtask(() {
                        notifier.changeClass(
                          teacherId: widget.teacherId,
                          newClassId: classes.first,
                        );
                      });
                    }

                    return Container(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Class",
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
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// ✅ عرض التاسكات
                Builder(
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

                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.53,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.strokeColor,
                            width: 1,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: state.tasks.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TaskItemCard(
                              task: state.tasks[index],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),
                const LastUpdateText(),
                const SizedBox(height: 80),
              ],
            ),
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