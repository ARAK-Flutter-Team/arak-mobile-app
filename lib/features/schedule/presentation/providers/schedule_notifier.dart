import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_schedules.dart';
import 'schedule_filter_provider.dart';
import 'schedule_state.dart';

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final GetSchedules getSchedules;
  final Ref _ref;

  ScheduleNotifier(this.getSchedules, this._ref) : super(const ScheduleInitial());

  Future<void> loadSchedules() async {
    final filters = _ref.read(scheduleFiltersProvider);

    print('Loading schedules with filters: ${filters.toQueryParams()}');
    state = const ScheduleLoading();

    try {
      final result = await getSchedules(filters);
      print('Loaded ${result.length} schedule items');
      state = ScheduleLoaded(result);
    } catch (e) {
      print('Error loading schedules: $e');
      state = ScheduleError(e.toString());
    }
  }
}