import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/add_task_notifier.dart';
import '../providers/teacher_classes_provider.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../widgets/deadline_picker.dart';
import '../widgets/subject_dropdown.dart';
import '../widgets/task_text_field.dart';

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
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addTaskNotifierProvider);
    final notifier = ref.read(addTaskNotifierProvider.notifier);

    final classesAsync = ref.watch(teacherClassesProvider(widget.teacherId));

    return Scaffold(
      appBar: AppMainAppBar(
        title: "Add New Task",
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
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                const Text('Assign a new activity or homework to your students.'),
                const SizedBox(height: 24),

// 👇 Class Dropdown
                classesAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => const Text("Error loading classes"),
                  data: (classes) {
                    if (classes.isEmpty) {
                      return const Text("No classes available");
                    }

                    if (state.selectedClassId == null) {
                      Future.microtask(() {
                        notifier.setClass(classes.first);
                      });
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Class",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),

                        AppDropdown(
                          selectedClass: state.selectedClassId ?? classes.first,
                          classes: classes,
                          onChanged: notifier.setClass,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),

                // 👇 Task Title
                TaskTextField(
                  title: "Task Title",
                  controller: _titleController,
                  hint: "Enter task title",
                  errorText: state.titleError,
                  onChanged: (_) => notifier.clearTitleError(),
                ),
                const SizedBox(height: 20),

                // 👇 Description
                TaskTextField(
                  title: "Description",
                  controller: _descController,
                  hint: "Write task description",
                  maxLines: 3,
                  errorText: state.descriptionError,
                  onChanged: (_) => notifier.clearDescriptionError(),
                ),
                const SizedBox(height: 30),

                // 👇 Subject Dropdown
                SubjectDropdown(
                  selectedSubject: state.selectedSubject != null &&
                      state.selectedSubject!.isNotEmpty &&
                      const ["Math", "Science", "English"]
                          .contains(state.selectedSubject)
                      ? state.selectedSubject
                      : null,
                  subjects: const ["Math", "Science", "English"],
                  onChanged: notifier.setSubject,
                  errorText: state.subjectError,   // 👈 ده هنا
                ),
                const SizedBox(height: 20),

                // 👇 Deadline Picker
                DeadlinePicker(
                  selectedDate: state.deadline,
                  onDateSelected: notifier.setDeadline,
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),

          // 👇 زر Assign Task
          Positioned(
            bottom: 16,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () async {
                 final isValid = notifier.validate(
                    title: _titleController.text.trim(),
                    description: _descController.text.trim(),
                  );

                  if (!isValid) return;

                  await notifier.submitTask(
                    title: _titleController.text.trim(),
                    description: _descController.text.trim(),
                  );

                  if (context.mounted) context.pop();
                },
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Assign Task"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}