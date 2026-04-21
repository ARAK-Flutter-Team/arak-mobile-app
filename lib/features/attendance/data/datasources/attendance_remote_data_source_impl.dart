/*import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/attendance_record.dart';
import '../models/attendance_model.dart';
import 'attendance_remote_datasource.dart';

class AttendanceRemoteDataSourceImpl
    implements AttendanceRemoteDataSource {

  @override
  Future<List<AttendanceModel>> getAttendanceForSession({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final key = "${classId}_${session.name}";

    final storedData = prefs.getString(key);

    if (storedData != null) {
      final List decoded = jsonDecode(storedData);

      return decoded
          .map((e) => AttendanceModel.fromJson(
        Map<String, dynamic>.from(e),
      ))
          .toList();
    }

    // لو أول مرة
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
  Future<void> submitAttendance(
      List<AttendanceModel> records,
      ) async {

    if (records.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    final key = "${records.first.classId}_${records.first.session.name}";

    final jsonString =
    jsonEncode(records.map((e) => e.toJson()).toList());

    await prefs.setString(key, jsonString);
  }
}*/
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/attendance_record.dart';
import '../models/attendance_model.dart';
import 'attendance_remote_datasource.dart';

class AttendanceRemoteDataSourceImpl
    implements AttendanceRemoteDataSource {

  final Dio dio;

  AttendanceRemoteDataSourceImpl(this.dio);

  @override
  Future<List<AttendanceModel>> getAttendanceForSession({
    required String classId,
    required DateTime date,
    required AttendanceSession session,
  }) async {

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(" TOKEN = $token");
    print(" CLASS ID = $classId");
    print(" DATE = ${date.toIso8601String()}");

    final response = await dio.get(
      "/Attendance/class/${int.parse(classId)}",
      queryParameters: {
        "date": date.toIso8601String().split('T').first,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    print(" RESPONSE STATUS = ${response.statusCode}");
    print(" RESPONSE DATA = ${response.data}");
    final List data = response.data as List;

    return data
        .map((e) => AttendanceModel.fromJson(
      Map<String, dynamic>.from(e),
    ))
        .toList();
  }

  @override
  Future<void> submitAttendance(
      List<AttendanceModel> records,
      ) async {

    if (records.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final body = {
      "records": records.map((e) => e.toJson()).toList(),
    };

    await dio.post(
      "/Attendance/bulk",
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
}