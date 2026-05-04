import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';

import '../../data/datasources/attendance_remote_data_source_impl.dart';
import '../../data/datasources/attendance_remote_datasource.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../domain/usecases/load_session_attendance_usecase.dart';
import '../../domain/usecases/submit_attendance_usecase.dart';

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
