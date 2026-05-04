// lib/features/schedule/data/providers/schedule_data_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import '../datasources/schedule_remote_data_source.dart';
import '../repositories/schedule_repository_impl.dart';
import '../../domain/repositories/schedule_repository.dart';

final scheduleRemoteDataSourceProvider =
    Provider<ScheduleRemoteDataSource>((ref) {
  return ScheduleRemoteDataSource(ref.watch(dioProvider));
});

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl(ref.watch(scheduleRemoteDataSourceProvider));
});
