/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/load_session_attendance_usecase.dart';
import '../../../domain/usecases/submit_attendance_usecase.dart';
import '../state/attendance_state.dart';

class AttendanceNotifier extends StateNotifier<AttendanceState> {
  final LoadSessionAttendanceUseCase loadUseCase;
  final SubmitAttendanceUseCase submitUseCase;

  AttendanceNotifier(this.loadUseCase, this.submitUseCase)
      : super(AttendanceState());

  Future<void> load(String classId) async {
    state = state.copyWith(isLoading: true);

    try {
      final records = await loadUseCase(
        classId: classId,
        date: state.selectedDate,
        session: state.selectedSession,
      );

      state = state.copyWith(
        isLoading: false,
        records: records,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> submit() async {
    state = state.copyWith(isLoading: true);

    try {
      await submitUseCase(state.records);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

*/