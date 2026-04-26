/*import '../../domain/entities/schedule_item.dart';

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
}*/
import '../../domain/entities/schedule_item.dart';

class ScheduleItemModel extends ScheduleItem {
  const ScheduleItemModel({
    required super.id,
    required super.dayOfWeek,
    required super.dayName,
    required super.title,
    required super.startTime,
    required super.endTime,
    required super.location,
    required super.classId,
    required super.subjectId,
    required super.teacherId,
    required super.subjectName,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    const days = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday',
      'Thursday', 'Friday', 'Saturday'
    ];

    final dayOfWeek = json['dayOfWeek'] ?? 0;
    final dayName = days[dayOfWeek % 7];

    String formatTime(dynamic time) {
      if (time == null) return '--:--';
      String timeStr = time.toString();
      if (timeStr.contains('.')) {
        timeStr = timeStr.split('.').first;
      }
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
      }
      return timeStr;
    }

    String getSubjectName(json) {
      if (json['subject'] != null && json['subject']['name'] != null) {
        return json['subject']['name'];
      }
      if (json['subjectName'] != null && json['subjectName'].toString().isNotEmpty) {
        return json['subjectName'];
      }
      if (json['classId'] != null && json['classId'] != 0) {
        return 'Class ${json['classId']}';
      }
      return 'Lesson';
    }

    return ScheduleItemModel(
      id: json['id'] ?? 0,
      dayOfWeek: dayOfWeek,
      dayName: dayName,
      title: getSubjectName(json),
      startTime: formatTime(json['startTime']),
      endTime: formatTime(json['endTime']),
      location: json['location'] ?? '',
      classId: json['classId'] ?? 0,
      subjectId: json['subjectId'] ?? 0,
      teacherId: json['teacherId'] ?? 0,
      subjectName: getSubjectName(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dayOfWeek': dayOfWeek,
      'dayName': dayName,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'location': location,
      'classId': classId,
      'subjectId': subjectId,
      'teacherId': teacherId,
      'subjectName': subjectName,
    };
  }
}