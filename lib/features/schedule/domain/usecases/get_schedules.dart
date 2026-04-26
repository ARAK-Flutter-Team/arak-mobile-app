import '../entities/schedule_filters.dart';
import '../entities/schedule_item.dart';
import '../repositories/schedule_repository.dart';

class GetSchedules {
  final ScheduleRepository repository;

  GetSchedules(this.repository);

  Future<List<ScheduleItem>> call(ScheduleFilters filters) {
    return repository.getSchedules(filters);
  }
}