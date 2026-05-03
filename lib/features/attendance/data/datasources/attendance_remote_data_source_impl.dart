import 'package:dio/dio.dart';
import '../models/attendance_response_model.dart';
import 'attendance_remote_datasource.dart';

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final Dio dio;

  AttendanceRemoteDataSourceImpl(this.dio);

  @override
  Future<AttendanceResponseModel> getAttendanceForSession({
    required String classId,
    required DateTime date,
  }) async {
    print(" [ATTENDANCE] GET Request Started");
    print(" Class ID: $classId");
    print(" Date: ${date.toIso8601String()}");

    try {
      final response = await dio.get(
        "/Attendance/class/${int.parse(classId)}",
        queryParameters: {
          "date": date.toIso8601String().split('T').first,
        },
      );

      print(" [ATTENDANCE] Response Status: ${response.statusCode}");
      print(" Response Data: ${response.data}");

      if (response.statusCode == 200) {
        return AttendanceResponseModel.fromJson(response.data);
      } else {
        throw Exception("Unexpected status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print(" [ATTENDANCE] Dio Error: ${e.type}");
      print("Message: ${e.message}");
      rethrow;
    } catch (e) {
      print(" [ATTENDANCE] Error: $e");
      rethrow;
    }
  }

  @override
  Future<void> submitAttendance({
    required int classId,
    required String date,
    required String session,
    required List<Map<String, dynamic>> records,
  }) async {
    print(" [ATTENDANCE] Submitting ${records.length} records");

    try {
      final body = {
        "classId": classId,
        "date": date,
        "session": session,
        "records": records,
      };

      print(" Body: $body");

      await dio.post(
        "/Attendance/bulk",
        data: body,
      );

      print(" [ATTENDANCE] Submit successful");
    } on DioException catch (e) {
      print(" [ATTENDANCE] Submit Error: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print(" [ATTENDANCE] Submit Error: $e");
      rethrow;
    }
  }
}