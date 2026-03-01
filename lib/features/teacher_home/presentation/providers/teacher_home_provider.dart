/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/teacher_home_remote_data_source.dart';
import '../../data/datasources/teacher_home_mock_data_source.dart';
import '../../data/repositories/teacher_home_repository_impl.dart';

import '../../domain/repositories/teacher_home_repository.dart';
import '../../domain/usecases/get_teacher_home_data.dart';
import '../../domain/entities/teacher_home_entity.dart';

/// 1️⃣ DataSource Provider
final teacherHomeDataSourceProvider =
Provider<TeacherHomeRemoteDataSource>((ref) {

  // 🔁 حالياً بنستخدم Mock
  return TeacherHomeMockDataSource();

  // ✅ لما الباك يجهز:
  // final dio = ref.read(dioProvider);
  // return TeacherHomeRemoteDataSourceImpl(dio);
});


/// 2️⃣ Repository Provider
final teacherHomeRepositoryProvider =
Provider<TeacherHomeRepository>((ref) {
  return TeacherHomeRepositoryImpl(
    ref.read(teacherHomeDataSourceProvider),
  );
});


/// 3️⃣ UseCase Provider
final getTeacherHomeDataProvider =
Provider<GetTeacherHomeData>((ref) {
  return GetTeacherHomeData(
    ref.read(teacherHomeRepositoryProvider),
  );
});


/// 4️⃣ FutureProvider للشاشة
final teacherHomeProvider =
FutureProvider<TeacherHomeEntity>((ref) async {

  final useCase = ref.watch(getTeacherHomeDataProvider);
  final result = await useCase();

  return result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
  );
});*/
/*import 'package:flutter_riverpod/flutter_riverpod.dart';

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

/// ================= Teacher Profile Provider =================
final teacherProfileProvider =
FutureProvider<TeacherProfile>((ref) async {
  await Future.delayed(const Duration(milliseconds: 500));

  return TeacherProfile(
    teacherName: "Mr. Ahmed",
    subjectName: "Mathematics",
    profileImage:
    "download (1).jpg",
  );
});

/// ================= Teacher Performance Provider =================
final teacherPerformanceProvider =
FutureProvider<double>((ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return 82.0;
});
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
final teacherProfileProvider = FutureProvider<TeacherProfile>((ref) async {
  await Future.delayed(const Duration(milliseconds: 500));

  return TeacherProfile(
    teacherName: "Mr. Ahmed",
    subjectName: "Mathematics",
    profileImage: "https://www.pinterest.com/pin/820781100878995639/",
  );

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
});

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