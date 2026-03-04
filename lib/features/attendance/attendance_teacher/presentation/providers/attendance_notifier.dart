/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/attendance_record.dart';
import '../../../domain/entities/attendance_session.dart';
import '../../../domain/entities/attendance_status.dart';
import '../../../domain/usecases/load_session_attendance_usecase.dart';
import '../../../domain/usecases/submit_attendance_usecase.dart';
import '../state/attendance_state.dart';

/// ----------------------------
/// Notifier
/// ----------------------------
class AttendanceNotifier extends StateNotifier<AttendanceState> {
  final LoadSessionAttendanceUseCase loadUseCase;
  final SubmitAttendanceUseCase submitUseCase;

  AttendanceNotifier(
      this.loadUseCase,
      this.submitUseCase,
      ) : super(AttendanceState());

  /// تحميل بيانات الجلسة
  Future<void> load({
    required String classId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

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

  /// تغيير الجلسة (Morning / Afternoon)
  void changeSession(AttendanceSession session) {
    state = state.copyWith(selectedSession: session);
  }

  /// تغيير التاريخ
  void changeDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  /// تغيير حالة طالب معين
  void updateStudentStatus({
    required String studentId,
    required AttendanceStatus status,
  }) {
    final updated = state.records.map((record) {
      if (record.studentId == studentId) {
        return AttendanceRecord(
          studentId: record.studentId,
          classId: record.classId,
          date: record.date,
          session: record.session,
          status: status,
        );
      }
      return record;
    }).toList();

    state = state.copyWith(records: updated);
  }

  /// إرسال الغياب
  Future<void> submit() async {
    state = state.copyWith(isLoading: true, error: null);

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

/// ----------------------------
/// Provider
/// ----------------------------
/*final attendanceNotifierProvider =
StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  return AttendanceNotifier(
    ref.read(loadAttendanceUseCaseProvider),
    ref.read(submitAttendanceUseCaseProvider),
  );
});*/
*/