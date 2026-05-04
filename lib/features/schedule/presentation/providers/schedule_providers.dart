import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/app_config.dart';
import '../../data/datasources/schedule_remote_data_source.dart';
import '../../data/datasources/schedule_remote_data_source_impl.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../../domain/usecases/get_schedules.dart';
import 'schedule_notifier.dart';
import 'schedule_state.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    headers: {"Content-Type": "application/json"},
  ));
});

final scheduleRemoteDataSourceProvider =
Provider<ScheduleRemoteDataSource>((ref) {
  return ScheduleRemoteDataSourceImpl(ref.read(dioProvider));
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl(ref.read(scheduleRemoteDataSourceProvider));
});

final getSchedulesProvider = Provider<GetSchedules>((ref) {
  return GetSchedules(ref.read(scheduleRepositoryProvider));
});

final teacherScheduleNotifierProvider =
StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  return ScheduleNotifier(
    ref.read(getSchedulesProvider),
    ref,
  );
});