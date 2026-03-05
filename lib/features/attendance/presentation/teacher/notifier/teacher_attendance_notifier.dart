/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/attendance_record.dart';
import '../../../domain/usecases/load_session_attendance_usecase.dart';
import '../../../domain/usecases/submit_attendance_usecase.dart';
import '../../state/attendance_state.dart';

class TeacherAttendanceNotifier extends StateNotifier<AttendanceState> {
  final LoadAttendanceUseCase loadUseCase;
  final SubmitAttendanceUseCase submitUseCase;

  TeacherAttendanceNotifier(
      this.loadUseCase,
      this.submitUseCase,
      ) : super(const AttendanceState());

  Future<void> load(String classId) async {
    state = state.copyWith(isLoading: true);

    final result = await loadUseCase(
      classId: classId,
      date: DateTime.now(),
      session: AttendanceSession.morning,
    );

    state = state.copyWith(
      isLoading: false,
      records: result,
    );
  }

  void toggleStatus(String studentId) {
    final updated = state.records.map((record) {
      if (record.studentId != studentId) return record;

      AttendanceStatus newStatus;

      switch (record.status) {
        case AttendanceStatus.present:
          newStatus = AttendanceStatus.late;
          break;
        case AttendanceStatus.late:
          newStatus = AttendanceStatus.absent;
          break;
        case AttendanceStatus.absent:
          newStatus = AttendanceStatus.present;
          break;
      }

      return record.copyWith(status: newStatus);
    }).toList();

    state = state.copyWith(records: updated);
  }

  Future<bool> save() async {
    try {
      state = state.copyWith(isSaving: true);

      await submitUseCase(state.records);

      state = state.copyWith(isSaving: false);
      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false);
      return false;
    }
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/attendance_record.dart';
import '../../../domain/usecases/load_session_attendance_usecase.dart';
import '../../../domain/usecases/submit_attendance_usecase.dart';
import '../../state/attendance_state.dart';

class TeacherAttendanceNotifier extends StateNotifier<AttendanceState> {
  final LoadAttendanceUseCase loadUseCase;
  final SubmitAttendanceUseCase submitUseCase;

  TeacherAttendanceNotifier(
      this.loadUseCase,
      this.submitUseCase,
      ) : super(const AttendanceState());

  /*Future<void> load(
      String classId,
      AttendanceSession session,
      ) async {

    state = state.copyWith(isLoading: true);

    final result = await loadUseCase(
      classId: classId,
      date: DateTime.now(),
      session: session,
    );

    state = state.copyWith(
      isLoading: false,
      records: result,
    );
  }*/
  Future<void> load(String classId, AttendanceSession session) async {
    state = state.copyWith(isLoading: true);

    final result = await loadUseCase(
      classId: classId,
      date: DateTime.now(),
      session: session,
    );

    state = state.copyWith(
      isLoading: false,
      records: result,
    );
  }
  void toggleStatus(String studentId) {

    final updated = state.records.map((record) {

      if (record.studentId != studentId) return record;

      AttendanceStatus newStatus;

      switch (record.status) {
        case AttendanceStatus.present:
          newStatus = AttendanceStatus.late;
          break;

        case AttendanceStatus.late:
          newStatus = AttendanceStatus.absent;
          break;

        case AttendanceStatus.absent:
          newStatus = AttendanceStatus.present;
          break;
      }

      return record.copyWith(status: newStatus);

    }).toList();

    state = state.copyWith(records: updated);
  }

  Future<bool> save() async {

    try {

      state = state.copyWith(isSaving: true);

      await submitUseCase(state.records);

      state = state.copyWith(isSaving: false);

      return true;

    } catch (e) {

      state = state.copyWith(isSaving: false);

      return false;
    }
  }
}