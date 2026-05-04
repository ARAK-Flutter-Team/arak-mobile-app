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
  final dio = Dio(BaseOptions(
    baseUrl: AppConfig.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      "Content-Type": "application/json",
    },
  ));
  return dio;
});

final scheduleRemoteDataSourceProvider = Provider<ScheduleRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return ScheduleRemoteDataSourceImpl(dio);
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  final remote = ref.read(scheduleRemoteDataSourceProvider);
  return ScheduleRepositoryImpl(remote);
});

final getSchedulesProvider = Provider<GetSchedules>((ref) {
  final repo = ref.read(scheduleRepositoryProvider);
  return GetSchedules(repo);
});

final teacherScheduleNotifierProvider = StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  final useCase = ref.read(getSchedulesProvider);
  return ScheduleNotifier(useCase, ref);
});