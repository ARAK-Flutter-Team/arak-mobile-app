/*import '../../domain/entities/schedule_item.dart';

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
}*/
// lib/features/schedule/data/models/schedule_item_model.dart
/*import '../../domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  ScheduleItemModel({
    required super.id,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.location,
    required super.subjectId,
    required super.teacherId,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    return ScheduleItemModel(
      id: json['id'] ?? 0,
      dayOfWeek: json['dayOfWeek'] ?? 0,
      startTime: _parseTicks(json['startTime']['ticks']),
      endTime: _parseTicks(json['endTime']['ticks']),
      location: json['location'] ?? '',
      subjectId: json['subjectId'] ?? 0,
      teacherId: json['teacherId'] ?? 0,
    );
  }

  // فنكشن لتحويل الـ Ticks لـ HH:mm
  static String _parseTicks(int ticks) {
    // الـ Tick الواحد في .NET يساوي 100 نانو ثانية
    final microSeconds = ticks ~/ 10;
    final duration = Duration(microseconds: microSeconds);
    final hours = duration.inHours.remainder(24).toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes";
  }
}*/
import '../../domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  ScheduleItemModel({
    required super.day,
    required super.title,
    required super.startTime,
    required super.endTime,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    // 1. تحويل رقم اليوم (0=Sunday, 1=Monday..) إلى اسم
    const days = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday',
      'Thursday', 'Friday', 'Saturday'
    ];
    int dayIndex = json['dayOfWeek'] ?? 0;
    String dayName = days[dayIndex % 7];

    // 2. تحويل الـ Ticks (من Swagger) إلى وقت HH:mm
    String formatTime(dynamic timeJson) {
      if (timeJson == null) return '--:--';
      if (timeJson is Map && timeJson.containsKey('ticks')) {
        int ticks = timeJson['ticks'];
        // Tick formula: 600,000,000 ticks = 1 minute
        int totalMinutes = (ticks / 600000000).floor();
        int h = (totalMinutes / 60).floor();
        int m = totalMinutes % 60;
        return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
      }
      return '--:--';
    }

    // 3. تحضير العنوان (Title)
    // الباك يرجع classId و subjectId فقط. هنا نولد عنوان مؤقت.
    // لو الباك هيبعت اسم المادة (SubjectName) استقبليه بدل السطر التالي.
    String title = "Class ${json['classId'] ?? 'N/A'}";

    return ScheduleItemModel(
      day: dayName,
      title: title,
      startTime: formatTime(json['startTime']),
      endTime: formatTime(json['endTime']),
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
