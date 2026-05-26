import 'package:arak_app/features/tasks/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/task.dart';
import '../../domain/entities/task_student_status.dart';
import '../../domain/usecases/get_parent_tasks.dart';
import '../../domain/usecases/get_task_status.dart';

// ── State
class ParentTasksState {
  final List<Task> tasks;
  final bool isLoading;
  final String? error;

  const ParentTasksState({
    required this.tasks,
    required this.isLoading,
    this.error,
  });

  factory ParentTasksState.initial() => const ParentTasksState(
        tasks: [],
        isLoading: false,
        error: null,
      );

  ParentTasksState copyWith({
    List<Task>? tasks,
    bool? isLoading,
    Object? error = _sentinel,
  }) {
    return ParentTasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
    );
  }

  static const _sentinel = Object();
}

// ── Notifier
class ParentTasksNotifier extends StateNotifier<ParentTasksState> {
  final GetParentTasks getParentTasks;
  final GetTaskStatus getTaskStatus;

  ParentTasksNotifier({
    required this.getParentTasks,
    required this.getTaskStatus,
  }) : super(ParentTasksState.initial());

  Future<void> fetchTasks({required String studentId}) async {
    state = state.copyWith(isLoading: true, error: null, tasks: []);

    try {
      final tasks = await getParentTasks(studentId: studentId);

      // ✅ لكل تاسك، نجيب status الطالب الحقيقي من الـ API
      final updatedTasks = await Future.wait(tasks.map((task) async {
        try {
          final taskIdInt = int.tryParse(task.id) ?? 0;
          final cleanStudentId = studentId.trim();
          final cleanStudentIdInt = int.tryParse(cleanStudentId);
          final statuses = await getTaskStatus(taskIdInt);

          // نلاقي الطالب ده بالظبط في الـ list بشكل مرن وآمن
          // Using a manual nullable lookup to avoid firstWhere/orElse type mismatch
          // (orElse must return the same concrete runtime type as the list elements)
          TaskStudentStatus? studentStatus;
          for (final s in statuses) {
            final cleanSId = s.studentId.trim();
            if (cleanSId == cleanStudentId) {
              studentStatus = s;
              break;
            }
            final cleanSIdInt = int.tryParse(cleanSId);
            if (cleanSIdInt != null &&
                cleanStudentIdInt != null &&
                cleanSIdInt == cleanStudentIdInt) {
              studentStatus = s;
              break;
            }
          }
          if (studentStatus == null) {
            print('⚠️ Student $studentId not found in statuses for task ${task.id}');
          }

          // ✅ نحدث الـ status بناءً على isDone الحقيقي
          return Task(
            id: task.id,
            title: task.title,
            description: task.description,
            dueDate: task.dueDate,
            createdDate: task.createdDate,
            assignedTo: task.assignedTo,
            teacherId: task.teacherId,
            status: (studentStatus?.isDone ?? false)
                ? TaskStatus.completed
                : TaskStatus.pending,
          );
        } catch (e, stackTrace) {
          // طباعة الخطأ للمساعدة في التصحيح بدلاً من بلعه
          print('🔴 Error overriding status for task ${task.title} (ID: ${task.id}): $e');
          print(stackTrace);
          // لو فيه error في task معين، نرجعه زي ما هو
          return task;
        }
      }));

      print('====== PARENT TASKS DEBUG ======');
      print('Total tasks: ${updatedTasks.length}');
      for (final task in updatedTasks) {
        print('Task: ${task.title} | Status: ${task.status} | ID: ${task.id}');
      }
      print('================================');

      state = state.copyWith(tasks: updatedTasks, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to fetch tasks: ${e.toString()}",
      );
    }
  }
}

// ── Providers
final getParentTasksProvider = Provider((ref) => GetParentTasks(
      ref.watch(taskRepositoryProvider),
    ));

final parentTasksNotifierProvider =
    StateNotifierProvider<ParentTasksNotifier, ParentTasksState>((ref) {
  return ParentTasksNotifier(
    getParentTasks: ref.watch(getParentTasksProvider),
    getTaskStatus: ref.watch(getTaskStatusProvider), // ✅ أضفنا ده
  );
});
