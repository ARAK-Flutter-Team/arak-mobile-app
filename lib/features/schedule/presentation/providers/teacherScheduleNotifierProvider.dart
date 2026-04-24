/*import 'package:arak_app/features/schedule/presentation/providers/schedule_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/schedule_remote_data_source.dart';
import '../../data/datasources/schedule_remote_data_source_mock.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/usecases/get_teacher_schedule.dart';
import 'schedule_notifier.dart';

// Remote DataSource (Mock)
final scheduleRemoteDataSourceProvider =
Provider<ScheduleRemoteDataSource>((ref) {
  return ScheduleRemoteDataSourceMock();
});

// Repository
final scheduleRepositoryProvider =
Provider((ref) {
  final remote = ref.watch(scheduleRemoteDataSourceProvider);
  return ScheduleRepositoryImpl(remote);
});

// UseCase
final getTeacherScheduleProvider =
Provider((ref) {
  final repo = ref.watch(scheduleRepositoryProvider);
  return GetTeacherSchedule(repo);
});

// Notifier
final scheduleNotifierProvider =
StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  final useCase = ref.watch(getTeacherScheduleProvider);
  return ScheduleNotifier(useCase);
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/api_service.dart'; // تأكدي من المسار الصحيح
// ⚠️ ممنوع استدعاء schedual-of-student هنا نهائياً

// استدعاءات الطبقات الخاصة بالمعلم فقط
import '../../data/datasources/schedule_remote_data_source.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/usecases/get_teacher_schedule.dart';
import 'schedule_notifier.dart';
import 'schedule_state.dart';

// 1. ApiService (أساس الاتصال بالشبكة)
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// 2. Remote Data Source (مسؤول عن جلب البيانات الخام)
final scheduleRemoteDataSourceProvider =
Provider<ScheduleRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ScheduleRemoteDataSourceImpl(apiService);
});

// 3. Repository (مسؤول عن تنظيم البيانات)
final scheduleRepositoryProvider = Provider((ref) {
  final remote = ref.watch(scheduleRemoteDataSourceProvider);
  return ScheduleRepositoryImpl(remote);
});

// 4. Use Case (المنطق الخاص بالعملية)
final getTeacherScheduleProvider = Provider<GetTeacherSchedule>((ref) {
  final repo = ref.watch(scheduleRepositoryProvider);
  return GetTeacherSchedule(repo);
});

// 5. Notifier Provider (الطلوب: المسؤول عن إدارة حالة الواجهة)
final teacherScheduleNotifierProvider =
StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  // جلب الـ UseCase وتمريره للـ Notifier
  final useCase = ref.watch(getTeacherScheduleProvider);
  return ScheduleNotifier(useCase);
});