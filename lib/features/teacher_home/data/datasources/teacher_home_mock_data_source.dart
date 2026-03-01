import '../models/teacher_home_model.dart';
import 'teacher_home_remote_data_source.dart';

class TeacherHomeMockDataSource
    implements TeacherHomeRemoteDataSource {

  @override
  Future<TeacherHomeModel> getTeacherHomeData() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return TeacherHomeModel(
      teacherName: "Ms. Sara",
      subjectName: "Mathematics",
      performance: 87.5,
      assignedClasses: ["Grade 1A", "Grade 2B"],
      hasNewTasks: true,
      hasNewMessages: false,
      todayClassesCount: 3,
      nextClass: NextClassModel(
        className: "Grade 1A",
        startTime: "10:00 AM",
        endTime: "11:00 AM",
      ),
      recentActivities: [
        ActivityModel(
          iconPath: "assets/icons/task.svg",
          title: "New assignment uploaded",
        ),
      ],
    );
  }
}