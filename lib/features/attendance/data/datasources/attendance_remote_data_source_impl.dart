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
/*import 'package:dio/dio.dart';
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
      "/api/Attendance/class/${int.parse(classId)}",
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
      "/api/Attendance/bulk",
      data: body,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
  }
}*/
import 'package:dio/dio.dart';
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
    print(" [ATTENDANCE] GET Request Started");
    print(" Class ID: $classId");
    print(" Date: ${date.toIso8601String()}");

    try {
      /*final response = await dio.get(
        "/api/Attendance/class/${int.parse(classId)}",*/
      final response = await dio.get(
        "/api/Attendance/class/${int.parse(classId)}",
        queryParameters: {
          "date": date.toIso8601String().split('T').first,
        },
      );

      print(" [ATTENDANCE] Response Status: ${response.statusCode}");
      print(" [ATTENDANCE] Response Data: ${response.data}");

      print("  عدد الطلاب اللي رجعهم الباكند: ${response.data is List ? (response.data as List).length : 'مش قائمة'} ");
      if (response.statusCode == 200) {
        // Handling different response formats
        List dataList = [];
        if (response.data is List) {
          dataList = response.data as List;
        } else if (response.data is Map && response.data['data'] is List) {
          dataList = response.data['data'] as List;
        } else if (response.data is Map && response.data['\$values'] is List) {
          dataList = response.data['\$values'] as List;
        } else {
          print(" Unknown response format: ${response.data.runtimeType}");
          return [];
        }

        print(" Parsing ${dataList.length} records");

        return dataList
            .map((e) => AttendanceModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        print(" [ATTENDANCE] Unexpected Status: ${response.statusCode}");
        return [];
      }
    } on DioException catch (e) {
      print(" [ATTENDANCE] Dio Error: ${e.type}");
      print(" Message: ${e.message}");
      print(" Response: ${e.response?.data}");
      return [];
    } catch (e) {
      print(" [ATTENDANCE] Unexpected Error: $e");
      return [];
    }
  }

  @override
  Future<void> submitAttendance(List<AttendanceModel> records) async {
    if (records.isEmpty) return;

    print(" [ATTENDANCE] Submitting ${records.length} records");

    try {
      final body = {
        "classId": int.tryParse(records.first.classId) ?? 0,
        "date": DateTime.now().toIso8601String().split('T').first,
        "session": records.first.session == AttendanceSession.morning
            ? "Morning"
            : "Afternoon",
        "records": records.map((e) => {
          "studentId": int.tryParse(e.studentId) ?? 0,
          "status": e.status.name,
          "timeIn": null,
        }).toList(),
      };

      print(" Body: $body");

      /*await dio.post(
        "/api/Attendance/bulk",*/
      await dio.post(
        "/api/Attendance/bulk",
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
