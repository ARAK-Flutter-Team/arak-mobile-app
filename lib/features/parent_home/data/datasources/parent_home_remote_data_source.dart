import '../../../../shared/models/activity_model.dart';
import '../models/parent_home_model.dart';
import '../models/student_model.dart';

abstract class ParentHomeRemoteDataSource {
  Future<ParentHomeModel> getParentHomeData();
  Future<List<ActivityModel>> getRecentActivities();
}

class ParentHomeRemoteDataSourceImpl implements ParentHomeRemoteDataSource {
  // ✅ لما الـ API يجهز، استبدل الـ mock بـ apiClient.get(...)

  @override
  Future<ParentHomeModel> getParentHomeData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return ParentHomeModel(
      parentName: 'Ahmed',
      performancePercentage: 78,
      students: [
        StudentModel(
          id: '1',
          name: 'Shenouda Romany',
          grade: 9,
          classNumber: 3,
          profileImage: null,
          // assetImage: ("assets/images/shenouda.jpeg"),
          parentUsername: 'shenoudar3243@gmail.com',
          isVerified: true,
        ),
        StudentModel(
          id: '2',
          name: 'Ibrahem Saed',
          grade: 7,
          classNumber: 1,
          profileImage: null,
          // assetImage: ("assets/images/ibrahim.jpeg"),
          parentUsername: 'ibrahim23@gmail.com',
          isVerified: true,
        ),
      ],
    );
  }

  @override
  Future<List<ActivityModel>> getRecentActivities() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      ActivityModel(
        id: '1',
        title: 'Ahmed submitted drawing shapes task',
        iconPath: 'assets/icons/tasks.svg',
        keepOriginalIconColor: false,
        route: null,
      ),
      ActivityModel(
        id: '2',
        title: 'You marked grade 3 attendance',
        iconPath: 'assets/icons/attendance.svg',
        keepOriginalIconColor: false,
        route: null,
      ),
    ];
  }
}
