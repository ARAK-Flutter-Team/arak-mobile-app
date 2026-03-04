/*import '../../../domain/entities/attendance_record.dart';
import '../../../domain/entities/attendance_session.dart';

class AttendanceState {
  final bool isLoading;
  final List<AttendanceRecord> records;
  final AttendanceSession selectedSession;
  final DateTime selectedDate;
  final String? error;

  AttendanceState({
    this.isLoading = false,
    this.records = const [],
    this.selectedSession = AttendanceSession.morning,
    DateTime? selectedDate,
    this.error,
  }) : selectedDate = selectedDate ?? DateTime.now();

  AttendanceState copyWith({
    bool? isLoading,
    List<AttendanceRecord>? records,
    AttendanceSession? selectedSession,
    DateTime? selectedDate,
    String? error,
  }) {
    return AttendanceState(
      isLoading: isLoading ?? this.isLoading,
      records: records ?? this.records,
      selectedSession: selectedSession ?? this.selectedSession,
      selectedDate: selectedDate ?? this.selectedDate,
      error: error,
    );
  }
}*/