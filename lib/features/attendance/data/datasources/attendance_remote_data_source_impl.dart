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
}*/
/*import 'package:dio/dio.dart';
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
        "/api/Attendance/class/${int.parse(classId)}",
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
}*/
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
        "/api/Attendance/class/${int.parse(classId)}",
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