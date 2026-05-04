import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasources/schedule_remote_data_source.dart';
import '../../data/datasources/schedule_remote_data_source_impl.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../../domain/usecases/get_schedules.dart';
import 'schedule_notifier.dart';
import 'schedule_state.dart';

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