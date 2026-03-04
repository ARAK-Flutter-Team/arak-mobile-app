import 'package:arak_app/features/schedule/data/datasources/schedule_remote_data_source.dart';

import '../models/schedule_item_model.dart';

class ScheduleRemoteDataSourceMock
    implements ScheduleRemoteDataSource {

  @override
  Future<List<ScheduleItemModel>> getTeacherSchedule(
      int teacherId) async {
    await Future.delayed(const Duration(seconds: 1));

    if (teacherId == 1) {
      return  [
        ScheduleItemModel(
          day: "Sunday",
          title: "Class A",
          startTime: "09:00",
          endTime: "10:30",
        ),
        ScheduleItemModel(
          day: "Monday",
          title: "Class B",
          startTime: "11:00",
          endTime: "12:30",
        ),
      ];
    } else {
      return  [
        ScheduleItemModel(
          day: "Sunday",
          title: "Physics Lab",
          startTime: "08:00",
          endTime: "09:30",
        ),
        ScheduleItemModel(
          day: "Tuesday",
          title: "Class C",
          startTime: "10:00",
          endTime: "11:30",
        ),
      ];
    }
  }
}