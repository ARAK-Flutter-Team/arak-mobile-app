/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../providers/add_task_notifier.dart';
import '../providers/teacher_classes_provider.dart';
import '../providers/teacher_tasks_notifier.dart';
import '../widgets/deadline_picker.dart';
import '../widgets/subject_dropdown.dart';
import '../widgets/task_text_field.dart';
import '../../../../shared/widgets/app_dropdown.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  final String teacherId;
  const AddTaskPage({Key? key, required this.teacherId}) : super(key: key);

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  /*Future<void> _assignTask() async {
    final notifier = ref.read(addTaskNotifierProvider.notifier);

    final isValid = notifier.validate(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );

    if (!isValid) return;

    await notifier.submitTask(
      teacherId: widget.teacherId,
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );

    if (!mounted) return;

    AppSnackBar.show(
      context,
      message:AppLocalizations.of(context)!.taskAddedSuccessfully,
      type: AppSnackBarType.success,
    );

    // هنا بنعمل ريفريش للتاسكات
    /*ref.read(teacherTasksNotifierProvider.notifier)
        .loadSavedTasks();*/
    await ref.read(teacherTasksNotifierProvider.notifier).fetchTasks(
      teacherId: widget.teacherId,
      classId: ref.read(addTaskNotifierProvider).selectedClassId!,
    );
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) context.pop();
  }*/
  Future<void> _assignTask() async {
    final notifier = ref.read(addTaskNotifierProvider.notifier);

    final isValid = notifier.validate(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );

    if (!isValid) return;

    await notifier.submitTask(
      teacherId: widget.teacherId,
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );

    if (!mounted) return;

    AppSnackBar.show(
      context,
      message: AppLocalizations.of(context)!.taskAddedSuccessfully,
      type: AppSnackBarType.success,
    );

    //  Refresh من الباك مباشرة
    await ref.read(teacherTasksNotifierProvider.notifier).fetchTasks(
      teacherId: widget.teacherId,
      classId: ref.read(addTaskNotifierProvider).selectedClassId!,
    );

    if (mounted) context.pop();
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskNotifierProvider);
    final classesAsync = ref.watch(teacherClassesProvider(widget.teacherId));
//  Fix old Arabic values (VERY IMPORTANT)
    if (state.selectedSubject != null &&
        !["math", "science", "english"].contains(state.selectedSubject)) {
     /* Future.microtask(() {
        ref.read(addTaskNotifierProvider.notifier).setSubject("math");
      });*/
      final firstClass = classes.first.id; // أو name حسب الداتا عندك

      if (state.selectedClassId == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(addTaskNotifierProvider.notifier)
              .setClass(firstClass);
        });
      }
    }
    return Scaffold(

      appBar:  AppMainAppBar(
        title: AppLocalizations.of(context)!.addNewTask,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.assignANewActivityOrHomeworkToYourStudents),
                const SizedBox(height: 24),

                // Class Dropdown
                classesAsync.when(
                  loading: () => const CircularProgressIndicator(),
                  error: (e, _) => Text(AppLocalizations.of(context)!.errorLoadingClasses),
                  data: (classes) {
                    if (classes.isEmpty) return  Text(AppLocalizations.of(context)!.noClassesAvailable);

                    if (state.selectedClassId == null) {
                      Future.microtask(() =>
                          ref.read(addTaskNotifierProvider.notifier).setClass(classes.first));
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(AppLocalizations.of(context)!.selectClass),
                        const SizedBox(height: 8),
                        AppDropdown(
                          selectedClass: state.selectedClassId ?? classes.first,
                          classes: classes,
                          onChanged:
                          ref.read(addTaskNotifierProvider.notifier).setClass,
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                TaskTextField(
                  title: AppLocalizations.of(context)!.taskTitle,
                  controller: _titleController,
                  hint: AppLocalizations.of(context)!.enterTaskTitle,
                  errorText: state.titleError,
                  onChanged: (_) =>
                      ref.read(addTaskNotifierProvider.notifier).clearTitleError(),
                ),
                const SizedBox(height: 20),

                TaskTextField(
                  title: AppLocalizations.of(context)!.description,
                  controller: _descController,
                  hint: AppLocalizations.of(context)!.writeTaskDescription,
                  maxLines: 3,
                  errorText: state.descriptionError,
                  onChanged: (_) =>
                      ref.read(addTaskNotifierProvider.notifier).clearDescriptionError(),
                ),
                const SizedBox(height: 30),

                SubjectDropdown(
                  selectedSubject: state.selectedSubject,
                  subjects: const ["math", "science", "english"],
                 // subjects:  [AppLocalizations.of(context)!.math, AppLocalizations.of(context)!.science, AppLocalizations.of(context)!.english],
                  onChanged: ref.read(addTaskNotifierProvider.notifier).setSubject,
                  errorText: state.subjectError,
                ),
                const SizedBox(height: 20),

                DeadlinePicker(
                  selectedDate: state.deadline,
                  onDateSelected:
                  ref.read(addTaskNotifierProvider.notifier).setDeadline,
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),

          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: state.isLoading ? null : _assignTask,
                child: state.isLoading
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    :  Text(AppLocalizations.of(context)!.assignTask),
              ),
            )
          ),
        ],
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';

import '../providers/add_task_notifier.dart';
import '../providers/teacher_classes_provider.dart';
import '../providers/teacher_tasks_notifier.dart';

import '../widgets/deadline_picker.dart';
import '../widgets/subject_dropdown.dart';
import '../widgets/task_text_field.dart';
import '../../../../shared/widgets/app_dropdown.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  final String teacherId;

  const AddTaskPage({
    super.key,
    required this.teacherId,
  });

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _assignTask() async {
    final notifier = ref.read(addTaskNotifierProvider.notifier);

    final isValid = notifier.validate(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );

    if (!isValid) return;

    try {
      await notifier.submitTask(
        teacherId: widget.teacherId,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
      );

      if (!mounted) return;

      AppSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.taskAddedSuccessfully,
        type: AppSnackBarType.success,
      );

      //  refresh من الباك مباشرة
      final state = ref.read(addTaskNotifierProvider);

      await ref
          .read(teacherTasksNotifierProvider.notifier)
          .fetchTasks(
        teacherId: widget.teacherId,
        classId: state.selectedClassId!,
      );

      if (mounted) context.pop();
    } catch (e) {
      AppSnackBar.show(
        context,
        message: "Error: $e",
        type: AppSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskNotifierProvider);
    final classesAsync = ref.watch(teacherClassesProvider(widget.teacherId));

    return Scaffold(
      appBar: AppMainAppBar(
        title: AppLocalizations.of(context)!.addNewTask,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                Text(
                  AppLocalizations.of(context)!
                      .assignANewActivityOrHomeworkToYourStudents,
                ),

                const SizedBox(height: 24),

                // ================= CLASS =================
                classesAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, _) => Text(
                    AppLocalizations.of(context)!.errorLoadingClasses,
                  ),
                  data: (classes) {
                    if (classes.isEmpty) {
                      return Text(
                        AppLocalizations.of(context)!.noClassesAvailable,
                      );
                    }

                    // auto select first class
                    if (state.selectedClassId == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(addTaskNotifierProvider.notifier)
                            .setClass(classes.first);
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.selectClass),
                        const SizedBox(height: 8),

                        AppDropdown(
                          selectedClass:
                          state.selectedClassId ?? classes.first,
                          classes: classes,
                          onChanged: (value) {
                            ref
                                .read(addTaskNotifierProvider.notifier)
                                .setClass(value);
                          },
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ================= TITLE =================
                TaskTextField(
                  title: AppLocalizations.of(context)!.taskTitle,
                  controller: _titleController,
                  hint: AppLocalizations.of(context)!.enterTaskTitle,
                  errorText: state.titleError,
                  onChanged: (_) => ref
                      .read(addTaskNotifierProvider.notifier)
                      .clearTitleError(),
                ),

                const SizedBox(height: 20),

                // ================= DESCRIPTION =================
                TaskTextField(
                  title: AppLocalizations.of(context)!.description,
                  controller: _descController,
                  hint: AppLocalizations.of(context)!.writeTaskDescription,
                  maxLines: 3,
                  errorText: state.descriptionError,
                  onChanged: (_) => ref
                      .read(addTaskNotifierProvider.notifier)
                      .clearDescriptionError(),
                ),

                const SizedBox(height: 20),

                // ================= SUBJECT =================
                SubjectDropdown(
                  selectedSubject: state.selectedSubject,
                  subjects: const ["math", "science", "english"],
                  onChanged: (value) {
                    ref
                        .read(addTaskNotifierProvider.notifier)
                        .setSubject(value);
                  },
                  errorText: state.subjectError,
                ),

                const SizedBox(height: 20),

                // ================= DEADLINE =================
                DeadlinePicker(
                  selectedDate: state.deadline,
                  onDateSelected: (date) {
                    ref
                        .read(addTaskNotifierProvider.notifier)
                        .setDeadline(date);
                  },
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),

          // ================= BUTTON =================
          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: state.isLoading ? null : _assignTask,
                child: state.isLoading
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text(AppLocalizations.of(context)!.assignTask),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';

// استدعاء الـ Notifiers والـ Providers اللي عملناها
import '../providers/add_task_notifier.dart';
import '../providers/providers.dart'; // ده فيه subjectsProvider و الـ Providers المركزية
import '../providers/teacher_tasks_notifier.dart';

// استدعاء الـ Widgets الخاصة بالفورم
import '../widgets/deadline_picker.dart';
import '../widgets/subject_dropdown.dart';
import '../widgets/task_text_field.dart';
import '../../../../shared/widgets/app_dropdown.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  final String teacherId;

  const AddTaskPage({
    super.key,
    required this.teacherId,
  });

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _assignTask() async {
    final notifier = ref.read(addTaskNotifierProvider.notifier);

    final isValid = notifier.validate(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
    );

    if (!isValid) return;

    try {
      // استدعاء الفانكشن (لاحظي إننا منبعتيش teacherTasksNotifierProvider كبارامتر)
      await notifier.submitTask(
        teacherId: widget.teacherId,
        title: _titleController.text.trim(),
        description: _descController.text.trim(),
      );

      if (!mounted) return;

      AppSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.taskAddedSuccessfully,
        type: AppSnackBarType.success,
      );

      // تحديث القائمة
      final state = ref.read(addTaskNotifierProvider);

      if (state.selectedClassId != null) {
        await ref
            .read(teacherTasksNotifierProvider.notifier)
            .fetchTasks(
          teacherId: widget.teacherId,
          classId: state.selectedClassId!,
        );
      }

      if (mounted) context.pop();
    } catch (e) {
      AppSnackBar.show(
        context,
        message: "Error: $e",
        type: AppSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskNotifierProvider);
    final classesAsync = ref.watch(teacherClassesProvider(widget.teacherId));
    final subjectsAsync = ref.watch(subjectsProvider); // ✅ جلب المواد من الباك

    return Scaffold(
      appBar: AppMainAppBar(
        title: AppLocalizations.of(context)!.addNewTask,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),

                Text(
                  AppLocalizations.of(context)!
                      .assignANewActivityOrHomeworkToYourStudents,
                ),

                const SizedBox(height: 24),

                // ================= CLASS (From Backend) =================
                classesAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, _) => Text(
                    AppLocalizations.of(context)!.errorLoadingClasses,
                  ),
                  data: (classes) {
                    if (classes.isEmpty) {
                      return Text(
                        AppLocalizations.of(context)!.noClassesAvailable,
                      );
                    }

                    // Auto select first class
                    if (state.selectedClassId == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(addTaskNotifierProvider.notifier)
                            .setClass(classes.first);
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.selectClass),
                        const SizedBox(height: 8),

                        AppDropdown(
                          selectedClass:
                          state.selectedClassId ?? classes.first,
                          classes: classes,
                          onChanged: (value) {
                            ref
                                .read(addTaskNotifierProvider.notifier)
                                .setClass(value);
                          },
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ================= TITLE =================
                TaskTextField(
                  title: AppLocalizations.of(context)!.taskTitle,
                  controller: _titleController,
                  hint: AppLocalizations.of(context)!.enterTaskTitle,
                  errorText: state.titleError,
                  onChanged: (_) => ref
                      .read(addTaskNotifierProvider.notifier)
                      .clearTitleError(),
                ),

                const SizedBox(height: 20),

                // ================= DESCRIPTION =================
                TaskTextField(
                  title: AppLocalizations.of(context)!.description,
                  controller: _descController,
                  hint: AppLocalizations.of(context)!.writeTaskDescription,
                  maxLines: 3,
                  errorText: state.descriptionError,
                  onChanged: (_) => ref
                      .read(addTaskNotifierProvider.notifier)
                      .clearDescriptionError(),
                ),

                const SizedBox(height: 20),

                // ================= SUBJECT (From Backend) =================
                subjectsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text(
                    "Error loading subjects", // ممكن تغييرها لـ Localization
                  ),
                  data: (subjects) {
                    if (subjects.isEmpty) {
                      return Text("No subjects available");
                    }

                    // Auto-select first subject
                    if (state.selectedSubject == null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(addTaskNotifierProvider.notifier)
                            .setSubject(subjects.first);
                      });
                    }

                    return SubjectDropdown(
                      selectedSubject: state.selectedSubject,
                      subjects: subjects, //  Data from Backend
                      onChanged: (value) {
                        ref
                            .read(addTaskNotifierProvider.notifier)
                            .setSubject(value);
                      },
                      errorText: state.subjectError,
                    );
                  },
                ),

                const SizedBox(height: 20),

                // ================= DEADLINE =================
                DeadlinePicker(
                  selectedDate: state.deadline,
                  onDateSelected: (date) {
                    ref
                        .read(addTaskNotifierProvider.notifier)
                        .setDeadline(date);
                  },
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),

          // ================= BUTTON =================
          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: state.isLoading ? null : _assignTask,
                child: state.isLoading
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text(AppLocalizations.of(context)!.assignTask),
              ),
            ),
          ),
        ],
      ),
    );
  }
}