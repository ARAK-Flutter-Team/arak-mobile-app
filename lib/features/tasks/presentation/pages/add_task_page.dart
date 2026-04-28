import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/logger_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../../shared/widgets/app_snackbar.dart';
import '../../../../shared/widgets/app_dropdown.dart';
import '../providers/add_task_notifier.dart';
import '../providers/providers.dart';
import '../widgets/deadline_picker.dart';
import '../widgets/task_text_field.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  const AddTaskPage({super.key});

  @override
  ConsumerState<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppLogger.logInfo('========== ADD TASK PAGE INIT ==========');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _assignTask() async {
    AppLogger.logInfo('========== ASSIGN TASK BUTTON PRESSED ==========');
    final notifier = ref.read(addTaskNotifierProvider.notifier);
    final title = _titleController.text.trim();
    final description = _descController.text.trim();

    AppLogger.logInfo('Title: "$title", Description: "$description"');

    final isValid = notifier.validate(title: title, description: description);
    AppLogger.logInfo('Validation result: $isValid');
    if (!isValid) return;

    try {
      await notifier.submitTask(title: title, description: description);
      AppLogger.logSuccess('Task submitted successfully');

      if (!mounted) return;

      AppSnackBar.show(
        context,
        message: AppLocalizations.of(context)!.taskAddedSuccessfully,
        type: AppSnackBarType.success,
      );

      AppLogger.logInfo('Closing AddTaskPage');
      if (mounted) context.pop();
    } catch (e) {
      AppLogger.logError('ERROR in assign task: $e');
      if (!mounted) return;
      AppSnackBar.show(
        context,
        message: "Error: $e",
        type: AppSnackBarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.logInfo('========== ADD TASK PAGE BUILD ==========');
    final state = ref.watch(addTaskNotifierProvider);
    final classesAsync = ref.watch(teacherClassesProvider);
    final loc = AppLocalizations.of(context)!;

    AppLogger.logInfo('AddTaskState - selectedClassId: ${state.selectedClassId}');
    AppLogger.logInfo('AddTaskState - selectedClassId type: ${state.selectedClassId.runtimeType}');
    AppLogger.logInfo('AddTaskState - isLoading: ${state.isLoading}');

    return Scaffold(
      appBar: AppMainAppBar(title: loc.addNewTask),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(loc.assignANewActivityOrHomeworkToYourStudents),
            const SizedBox(height: 24),

            classesAsync.when(
              loading: () {
                AppLogger.logInfo('Classes loading...');
                return const Center(child: CircularProgressIndicator());
              },
              error: (e, _) {
                AppLogger.logError('Classes error: $e');
                return Text('Error: $e', style: const TextStyle(color: Colors.red));
              },
              data: (classes) {
                AppLogger.logInfo('Classes data loaded: $classes');
                if (classes.isEmpty) {
                  AppLogger.logWarning('Classes list is empty');
                  return Text(loc.noClassesAvailable, style: const TextStyle(color: Colors.red));
                }

                // حساب القيمة المضمونة
                String selectedValue;
                if (state.selectedClassId != null &&
                    state.selectedClassId!.isNotEmpty &&
                    classes.contains(state.selectedClassId!)) {
                  selectedValue = state.selectedClassId!;
                  AppLogger.logInfo('Using existing selectedClassId: "$selectedValue"');
                } else {
                  selectedValue = classes.first;
                  AppLogger.logInfo('Using first class as default: "$selectedValue"');
                  // تحديث الـ notifier بعد البناء
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppLogger.logInfo('PostFrameCallback: updating selectedClassId to "$selectedValue"');
                    ref.read(addTaskNotifierProvider.notifier).setClass(selectedValue);
                  });
                }

                AppLogger.logSuccess('Final selectedValue for dropdown: "$selectedValue"');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc.selectClass),
                    const SizedBox(height: 8),
                    AppDropdown(
                      selectedClass: selectedValue,
                      classes: classes,
                      onChanged: (value) {
                        AppLogger.logInfo('Dropdown changed to: "$value"');
                        if (value.isNotEmpty) {
                          ref.read(addTaskNotifierProvider.notifier).setClass(value);
                        }
                      },
                    ),
                    if (state.classError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          state.classError!,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            TaskTextField(
              title: loc.taskTitle,
              controller: _titleController,
              hint: loc.enterTaskTitle,
              errorText: state.titleError,
              onChanged: (_) => ref.read(addTaskNotifierProvider.notifier).clearTitleError(),
            ),
            const SizedBox(height: 20),
            TaskTextField(
              title: loc.description,
              controller: _descController,
              hint: loc.writeTaskDescription,
              maxLines: 3,
              errorText: state.descriptionError,
              onChanged: (_) => ref.read(addTaskNotifierProvider.notifier).clearDescriptionError(),
            ),
            const SizedBox(height: 20),
            DeadlinePicker(
              selectedDate: state.deadline,
              onDateSelected: (date) => ref.read(addTaskNotifierProvider.notifier).setDeadline(date),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: state.isLoading ? null : _assignTask,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: state.isLoading
                  ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(loc.assignTask),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}