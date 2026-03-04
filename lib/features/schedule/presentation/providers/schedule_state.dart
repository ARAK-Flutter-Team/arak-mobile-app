import '../../domain/entities/schedule_item.dart';

abstract class ScheduleState {
  const ScheduleState();
}

class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

class ScheduleLoaded extends ScheduleState {
  final List<ScheduleItem> schedule;

  const ScheduleLoaded(this.schedule);
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);
}