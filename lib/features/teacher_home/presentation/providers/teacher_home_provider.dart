import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../data/models/teacher_home_model.dart';

/// ================= Teacher Profile Model =================
class TeacherProfile {
  final String teacherName;
  final String subjectName;
  final String profileImage;

  TeacherProfile({
    required this.teacherName,
    required this.subjectName,
    required this.profileImage,
  });
}

/// ================= Teacher Profile Provider (Mock) =================
final teacherProfileProvider = Provider<TeacherHomeModel?>((ref) {
  final user = ref.watch(authProvider).user;

  if (user == null) return null;

  return TeacherHomeModel(
    teacherName: user.name, // 👈 الاسم الموحد
    subjectName: "Mathematics",
    performance: 0.85,
    assignedClasses: [],
    hasNewTasks: false,
    hasNewMessages: false,
    todayClassesCount: 0,
    nextClass: null,
    recentActivities: [],
  );
});
  /*
  // ================= Teacher Profile Provider (Real API) =================
  final api = ref.read(apiClientProvider); // API Client
  final response = await api.get('/teacher/profile');

  return TeacherProfile(
    teacherName: response.data['teacherName'],
    subjectName: response.data['subjectName'],
    profileImage: response.data['profileImage'],
  );
  */

/// ================= Teacher Performance Provider (Mock) =================
final teacherPerformanceProvider = FutureProvider<double>((ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return 82.0;

  /*
  // ================= Teacher Performance Provider (Real API) =================
  final api = ref.read(apiClientProvider); // API Client
  final response = await api.get('/teacher/performance');

  return response.data['performance'].toDouble();
  */
});