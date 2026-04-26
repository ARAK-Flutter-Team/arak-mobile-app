/*import '../../domain/entities/schedule_item.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ScheduleItem>> getTeacherSchedule(int teacherId) {
    return remoteDataSource.getTeacherSchedule(teacherId);
  }
  @override
  Future<List<ScheduleItem>> getStudentSchedule() {
    throw UnimplementedError();
  }
}*/
import '../../domain/entities/schedule_filters.dart';
import '../../domain/entities/schedule_item.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';
import '../models/schedule_item_model.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remoteDataSource;

  ScheduleRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ScheduleItem>> getSchedules(ScheduleFilters filters) async {
    final models = await remoteDataSource.getSchedules(filters);
    return models;
  }
}