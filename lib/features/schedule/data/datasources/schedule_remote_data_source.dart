import '../models/schedule_item_model.dart';
import '../../domain/entities/schedule_filters.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleItemModel>> getSchedules(ScheduleFilters filters);
}