import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/schedule_local_data_source.dart';
import '../repositories/schedule_repository_impl.dart';
import '../../domain/repositories/schedule_repository.dart';

// 1. Provider for Data Source
final scheduleLocalDataSourceProvider =
    Provider<ScheduleLocalDataSource>((ref) {
  return ScheduleLocalDataSource();
});

// 2. Provider for Repository
final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl(ref.watch(scheduleLocalDataSourceProvider));
});
