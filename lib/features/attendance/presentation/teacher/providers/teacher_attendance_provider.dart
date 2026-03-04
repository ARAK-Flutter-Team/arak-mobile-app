import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/attendance_dependencies_provider.dart';
import '../notifier/teacher_attendance_notifier.dart';
import '../../state/attendance_state.dart';

final teacherAttendanceNotifierProvider =
StateNotifierProvider<TeacherAttendanceNotifier, AttendanceState>(
      (ref) => TeacherAttendanceNotifier(
    ref.read(loadAttendanceUseCaseProvider),
    ref.read(submitAttendanceUseCaseProvider),
  ),
);