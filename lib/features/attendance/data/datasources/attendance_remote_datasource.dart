import '../models/attendance_model.dart';
import '../../domain/entities/attendance_record.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<AttendanceModel>> getAttendance(
      String classId, DateTime date, AttendanceSession session);

  Future<void> submitAttendance(List<AttendanceModel> records);
}

class AttendanceRemoteDataSourceImpl
    implements AttendanceRemoteDataSource {

  @override
  Future<List<AttendanceModel>> getAttendance(
      String classId, DateTime date, AttendanceSession session) async {

    await Future.delayed(const Duration(milliseconds: 800));

    return List.generate(
      10,
          (index) => AttendanceModel(
        studentId: "$index",
        studentName: "Student $index",
        classId: classId,
        date: date,
        session: session,
        status: AttendanceStatus.present,
      ),
    );
  }

  @override
  Future<void> submitAttendance(List<AttendanceModel> records) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}