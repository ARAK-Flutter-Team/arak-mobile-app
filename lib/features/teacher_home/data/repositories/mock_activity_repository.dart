import '../../../../shared/models/activity_model.dart';
import '../../domain/repositories/activity_repository.dart';

class MockActivityRepository implements ActivityRepository {
  @override
  Future<List<ActivityModel>> getRecentActivities(String role) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (role == "teacher") {
      return const [
        ActivityModel(
          id: "1",
          iconPath: 'assets/icons/tasks.svg',
          title: "You assigned a new task",
          route: "/teacher/tasks",
        ),
        ActivityModel(
          id: "2",
          iconPath: 'assets/icons/messages.svg',
          title: "New message from admin",
          route: "/teacher/messages",
        ),
      ];
    } else {
      return const [
        ActivityModel(
          id: "3",
          iconPath: 'assets/icons/attendance.svg',
          title: "Your child was marked present",
          route: "/parent/attendance",
        ),
      ];
    }
  }
}