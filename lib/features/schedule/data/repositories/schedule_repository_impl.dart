import '../../domain/entities/schedule_filters.dart';
import '../../domain/entities/schedule_item.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ScheduleItem>> getSchedules(ScheduleFilters filters) async {
    final models = await remoteDataSource.getSchedules(filters);
    return models;
  }
}
