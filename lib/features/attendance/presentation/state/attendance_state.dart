/*import '../../domain/entities/attendance_record.dart';

class AttendanceState {
  final bool isLoading;
  final bool isSaving;
  final List<AttendanceRecord> records;

  const AttendanceState({
    this.isLoading = false,
    this.isSaving = false,
    this.records = const [],
  });

  double get attendancePercentage {
    if (records.isEmpty) return 0;

    final attending = records.where(
          (e) =>
      e.status == AttendanceStatus.present ||
          e.status == AttendanceStatus.late,
    ).length;

    return (attending / records.length) * 100;
  }

  AttendanceState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<AttendanceRecord>? records,
  }) {
    return AttendanceState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      records: records ?? this.records,
    );
  }
}*/
import '../../domain/entities/attendance_record.dart';

class AttendanceState {
  final bool isLoading;
  final bool isSaving;
  final List<AttendanceRecord> records;

  // 🆕 كاش لكل session
  final Map<String, List<AttendanceRecord>> sessionCache;

  const AttendanceState({
    this.isLoading = false,
    this.isSaving = false,
    this.records = const [],
    this.sessionCache = const {},
  });

  double get attendancePercentage {
    if (records.isEmpty) return 0;

    final attending = records.where(
          (e) =>
      e.status == AttendanceStatus.present ||
          e.status == AttendanceStatus.late,
    ).length;

    return (attending / records.length) * 100;
  }

  AttendanceState copyWith({
    bool? isLoading,
    bool? isSaving,
    List<AttendanceRecord>? records,
    Map<String, List<AttendanceRecord>>? sessionCache,
  }) {
    return AttendanceState(
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      records: records ?? this.records,
      sessionCache: sessionCache ?? this.sessionCache,
    );
  }
}