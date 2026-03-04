import 'package:arak_app/features/schedule/presentation/providers/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/schedule_remote_data_source.dart';
import '../../data/datasources/schedule_remote_data_source_mock.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/usecases/get_teacher_schedule.dart';
import 'schedule_notifier.dart';

// Remote DataSource (Mock)
final scheduleRemoteDataSourceProvider =
Provider<ScheduleRemoteDataSource>((ref) {
  return ScheduleRemoteDataSourceMock();
});

// Repository
final scheduleRepositoryProvider =
Provider((ref) {
  final remote = ref.watch(scheduleRemoteDataSourceProvider);
  return ScheduleRepositoryImpl(remote);
});

// UseCase
final getTeacherScheduleProvider =
Provider((ref) {
  final repo = ref.watch(scheduleRepositoryProvider);
  return GetTeacherSchedule(repo);
});

// Notifier
final scheduleNotifierProvider =
StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  final useCase = ref.watch(getTeacherScheduleProvider);
  return ScheduleNotifier(useCase);
});