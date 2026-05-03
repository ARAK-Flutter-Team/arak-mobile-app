import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/datasources/attendance_remote_data_source_impl.dart';
import '../../data/datasources/attendance_remote_datasource.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../domain/usecases/load_session_attendance_usecase.dart';
import '../../domain/usecases/submit_attendance_usecase.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: "http://192.168.1.11:7000",
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      "Content-Type": "application/json",
    },
  ));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      print(
          "TOKEN from storage: ${token != null ? "Found (${token.substring(0, 20)}...)" : "NOT FOUND"}");

      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
        print("Token added to request headers");
      } else {
        print("No token found!");
      }

      print("REQUEST: ${options.method} ${options.uri}");
      return handler.next(options);
    },
    onResponse: (response, handler) {
      print("RESPONSE: ${response.statusCode} ${response.requestOptions.uri}");
      return handler.next(response);
    },
    onError: (error, handler) {
      print("ERROR: ${error.response?.statusCode} - ${error.message}");
      if (error.response?.data != null) {
        print("Error Data: ${error.response?.data}");
      }
      return handler.next(error);
    },
  ));

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    error: true,
    compact: false,
  ));

  return dio;
});

final attendanceRemoteDataSourceProvider = Provider<AttendanceRemoteDataSource>(
  (ref) => AttendanceRemoteDataSourceImpl(
    ref.read(dioProvider),
  ),
);

final attendanceRepositoryProvider = Provider<AttendanceRepositoryImpl>(
  (ref) => AttendanceRepositoryImpl(
    ref.read(attendanceRemoteDataSourceProvider),
  ),
);

final loadAttendanceUseCaseProvider = Provider<LoadAttendanceUseCase>(
  (ref) => LoadAttendanceUseCase(
    ref.read(attendanceRepositoryProvider),
  ),
);

final submitAttendanceUseCaseProvider = Provider<SubmitAttendanceUseCase>(
  (ref) => SubmitAttendanceUseCase(
    ref.read(attendanceRepositoryProvider),
  ),
);
