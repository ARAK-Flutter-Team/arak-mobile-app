import '../../domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  ScheduleItemModel({
    required super.day,
    required super.title,
    required super.startTime,
    required super.endTime,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    return ScheduleItemModel(
      day: json['day'],
      title: json['title'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'title': title,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}