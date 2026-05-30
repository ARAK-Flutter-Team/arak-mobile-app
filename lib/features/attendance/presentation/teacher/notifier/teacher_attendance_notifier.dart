/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/attendance_record.dart';
import '../../../domain/usecases/load_session_attendance_usecase.dart';
import '../../../domain/usecases/submit_attendance_usecase.dart';
import '../../state/attendance_state.dart';

class TeacherAttendanceNotifier extends StateNotifier<AttendanceState> {
  final LoadAttendanceUseCase loadUseCase;
  final SubmitAttendanceUseCase submitUseCase;
  int currentClassId = 0;
  String currentDate = '';
  String currentSession = 'Morning';

  TeacherAttendanceNotifier(this.loadUseCase, this.submitUseCase)
      : super(const AttendanceState());

  Future<void> load(String classId, AttendanceSession session) async {
    state = state.copyWith(isLoading: true);

    currentClassId = int.parse(classId);
    currentDate = DateTime.now().toIso8601String().split('T').first;
    currentSession = session == AttendanceSession.morning ? "Morning" : "Afternoon";

    final result = await loadUseCase(
      classId: classId,
      date: DateTime.now(),
    );

    state = state.copyWith(
      isLoading: false,
      records: result,
    );
  }

  void toggleStatus(int studentId) {
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

      await submitUseCase(
        classId: currentClassId,
        date: currentDate,
        session: currentSession,
        records: state.records,
      );

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

  int currentClassId = 0;
  String currentDate = '';
  String currentSession = 'Morning';

  TeacherAttendanceNotifier(
      this.loadUseCase,
      this.submitUseCase,
      ) : super(const AttendanceState());

  String _key(
      String classId,
      String date,
      AttendanceSession session,
      ) {
    return "$classId-$date-${session.name}";
  }

  AttendanceSession _currentSessionEnum() {
    return currentSession == "Morning"
        ? AttendanceSession.morning
        : AttendanceSession.afternoon;
  }

  Future<void> load(
      String classId,
      AttendanceSession session,
      ) async {
    state = state.copyWith(isLoading: true);

    currentClassId = int.parse(classId);
    currentDate = DateTime.now().toIso8601String().split('T').first;
    currentSession =
    session == AttendanceSession.morning ? "Morning" : "Afternoon";

    final cacheKey = _key(
      classId,
      currentDate,
      session,
    );

    if (state.sessionCache.containsKey(cacheKey)) {
      state = state.copyWith(
        isLoading: false,
        records: List<AttendanceRecord>.from(
          state.sessionCache[cacheKey]!,
        ),
      );
      return;
    }

    final result = await loadUseCase(
      classId: classId,
      date: DateTime.now(),
    );

    final updatedCache =
    Map<String, List<AttendanceRecord>>.from(state.sessionCache);

    updatedCache[cacheKey] = List<AttendanceRecord>.from(result);

    state = state.copyWith(
      isLoading: false,
      records: result,
      sessionCache: updatedCache,
    );
  }

  void toggleStatus(int studentId) {
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

    final cacheKey = _key(
      currentClassId.toString(),
      currentDate,
      _currentSessionEnum(),
    );

    final updatedCache =
    Map<String, List<AttendanceRecord>>.from(state.sessionCache);

    updatedCache[cacheKey] = List<AttendanceRecord>.from(updated);

    state = state.copyWith(
      records: updated,
      sessionCache: updatedCache,
    );
  }

  Future<bool> save() async {
    try {
      state = state.copyWith(isSaving: true);

      await submitUseCase(
        classId: currentClassId,
        date: currentDate,
        session: currentSession,
        records: state.records,
      );

      final cacheKey = _key(
        currentClassId.toString(),
        currentDate,
        _currentSessionEnum(),
      );

      final updatedCache =
      Map<String, List<AttendanceRecord>>.from(state.sessionCache);

      updatedCache[cacheKey] =
      List<AttendanceRecord>.from(state.records);

      state = state.copyWith(
        isSaving: false,
        sessionCache: updatedCache,
      );

      return true;
    } catch (e) {
      state = state.copyWith(isSaving: false);
      return false;
    }
  }
}