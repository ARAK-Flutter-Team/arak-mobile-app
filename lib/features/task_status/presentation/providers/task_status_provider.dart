import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../tasks/presentation/providers/providers.dart';
import '../controller/task_status_notifier.dart';
import '../state/task_status_state.dart';

final taskStatusProvider = StateNotifierProvider.autoDispose<TaskStatusNotifier, TaskStatusState>((ref) {
  final getTaskStatus = ref.watch(getTaskStatusProvider);
  final updateTaskStudentStatus = ref.watch(updateTaskStudentStatusProvider);

  return TaskStatusNotifier(
    getTaskStatus: getTaskStatus,
    updateTaskStudentStatus: updateTaskStudentStatus,
  );
});