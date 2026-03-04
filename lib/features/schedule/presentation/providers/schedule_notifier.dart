import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_teacher_schedule.dart';
import 'schedule_state.dart';

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final GetTeacherSchedule getTeacherSchedule;

  ScheduleNotifier(this.getTeacherSchedule)
      : super(const ScheduleInitial());

  Future<void> loadSchedule(int teacherId) async {
    state = const ScheduleLoading();

    try {
      final result = await getTeacherSchedule(teacherId);
      state = ScheduleLoaded(result);
    } catch (e) {
      state = ScheduleError(e.toString());
    }
  }
}