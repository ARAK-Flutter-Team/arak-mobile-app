/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/add_task_button.dart';
import '../widgets/class_dropdown.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/last_update_text.dart';
import '../widgets/loading_view.dart';
import '../widgets/task_item_card.dart';

class TeacherTasksScreen extends ConsumerStatefulWidget {
  final String teacherId;
  final List<String> classes;

  const TeacherTasksScreen({
    super.key,
    required this.teacherId,
    required this.classes,
  });

  @override
  ConsumerState<TeacherTasksScreen> createState() =>
      _TeacherTasksScreenState();
}

class _TeacherTasksScreenState
    extends ConsumerState<TeacherTasksScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.classes.isNotEmpty) {
        ref
            .read(teacherTasksNotifierProvider.notifier)
            .changeClass(
          teacherId: widget.teacherId,
          newClassId: widget.classes.first,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherTasksNotifierProvider);
    final notifier =
    ref.read(teacherTasksNotifierProvider.notifier);

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

                ClassDropdown(
                  selectedClass: state.selectedClass,
                  classes: widget.classes,
                  onChanged: (newClass) {
                    notifier.changeClass(
                      teacherId: widget.teacherId,
                      newClassId: newClass,
                    );
                  },
                ),

                const SizedBox(height: 20),

                /// ✅ الكونتينر ديناميك حسب عدد التاسكات
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

                    return Container(
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
                        shrinkWrap: true, // 👈 يخليه ياخد حجمه الطبيعي
                        physics:
                        const NeverScrollableScrollPhysics(), // 👈 يمنع اسكرول داخلي
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                              task: state.tasks[index]);
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),
                const LastUpdateText(),
                const SizedBox(height: 80), // مساحة فوق زرار ال Add
              ],
            ),
          ),
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AddTaskButton(
          onPressed: () {
            context.go('/add-task');
          },
        ),
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/add_task_button.dart';
import '../widgets/class_dropdown.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/last_update_text.dart';
import '../widgets/loading_view.dart';
import '../widgets/task_item_card.dart';
import '../widgets/tasks_container.dart';

class TeacherTasksScreen extends ConsumerStatefulWidget {
  final String teacherId;
  final List<String> classes;

  const TeacherTasksScreen({
    super.key,
    required this.teacherId,
    required this.classes,
  });

  @override
  ConsumerState<TeacherTasksScreen> createState() =>
      _TeacherTasksScreenState();
}

class _TeacherTasksScreenState
    extends ConsumerState<TeacherTasksScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.classes.isNotEmpty) {
        ref
            .read(teacherTasksNotifierProvider.notifier)
            .changeClass(
          teacherId: widget.teacherId,
          newClassId: widget.classes.first,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherTasksNotifierProvider);
    final notifier =
    ref.read(teacherTasksNotifierProvider.notifier);

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

                ClassDropdown(
                  selectedClass: state.selectedClass,
                  classes: widget.classes,
                  onChanged: (newClass) {
                    notifier.changeClass(
                      teacherId: widget.teacherId,
                      newClassId: newClass,
                    );
                  },
                ),

                const SizedBox(height: 20),

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
                        maxHeight:
                        MediaQuery.of(context).size.height * 0.53,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceVariant,
                          borderRadius:
                          BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.strokeColor,
                            width: 1,
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: state.tasks.length,
                          shrinkWrap: true,
                          physics:
                          const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TaskItemCard(
                                task: state.tasks[index]);
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

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: AddTaskButton(
          onPressed: () {
            context.go('/add-task');
          },
        ),
      ),
    );
  }
}