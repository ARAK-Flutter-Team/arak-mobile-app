/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/attendance_remote_data_source_impl.dart';
import '../../data/datasources/attendance_remote_datasource.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../domain/usecases/load_session_attendance_usecase.dart';
import '../../domain/usecases/submit_attendance_usecase.dart';

/// Remote DataSource
final attendanceRemoteDataSourceProvider =
Provider<AttendanceRemoteDataSource>(
      (ref) => AttendanceRemoteDataSourceImpl(),
);

/// Repository
final attendanceRepositoryProvider =
Provider<AttendanceRepositoryImpl>(
      (ref) => AttendanceRepositoryImpl(
    ref.read(attendanceRemoteDataSourceProvider),
  ),
);

/// UseCases
final loadAttendanceUseCaseProvider =
Provider<LoadAttendanceUseCase>(
      (ref) => LoadAttendanceUseCase(
    ref.read(attendanceRepositoryProvider),
  ),
);

final submitAttendanceUseCaseProvider =
Provider<SubmitAttendanceUseCase>(
      (ref) => SubmitAttendanceUseCase(
    ref.read(attendanceRepositoryProvider),
  ),
);*/
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/attendance_remote_data_source_impl.dart';
import '../../data/datasources/attendance_remote_datasource.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../domain/usecases/load_session_attendance_usecase.dart';
import '../../domain/usecases/submit_attendance_usecase.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.options.baseUrl = "http://192.168.1.9:5000/api";

  return dio;
});

final attendanceRemoteDataSourceProvider =
Provider<AttendanceRemoteDataSource>(
      (ref) => AttendanceRemoteDataSourceImpl(
    ref.read(dioProvider),
  ),
);

final attendanceRepositoryProvider =
Provider<AttendanceRepositoryImpl>(
      (ref) => AttendanceRepositoryImpl(
    ref.read(attendanceRemoteDataSourceProvider),
  ),
);

final loadAttendanceUseCaseProvider =
Provider<LoadAttendanceUseCase>(
      (ref) => LoadAttendanceUseCase(
    ref.read(attendanceRepositoryProvider),
  ),
);

final submitAttendanceUseCaseProvider =
Provider<SubmitAttendanceUseCase>(
      (ref) => SubmitAttendanceUseCase(
    ref.read(attendanceRepositoryProvider),
  ),
);