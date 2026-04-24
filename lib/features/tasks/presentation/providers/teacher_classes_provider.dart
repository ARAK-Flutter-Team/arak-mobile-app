/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
/// ===========================
/// Provider لجلب الكلاسات الخاصة بالمدرس
/// ===========================

/*final teacherClassesProvider =
FutureProvider.family<List<String>, String>((ref, teacherId) async {

  /// 🔹 لو السيرفر جاهز استخدمي الريبو أو الـ API هنا
  // final repo = ref.read(taskRepositoryProvider);
  // return await repo.getTeacherClasses(teacherId);

  /// 🔹 مؤقتًا محاكاة داتا ثابتة
  await Future.delayed(const Duration(milliseconds: 500));
  return [
    "Class A",
    "Class B",
    "Class C",
  ];

  /// 🔹 لاحقًا ممكن ترجعي List<ClassModel> بدل List<String>
  /// class ClassModel {
  ///   final String id;
  ///   final String name;
  ///   ClassModel({required this.id, required this.name});
  /// }
});*/
/*final teacherClassesProvider =
FutureProvider.family<List<String>, String>((ref, teacherId) async {
  await Future.delayed(const Duration(milliseconds: 500));

  return ["1", "2", "3"];
});*/
final teacherClassesProvider =
FutureProvider.family<List<String>, String>((ref, teacherId) async {
  final dio = ref.read(dioProvider);

  final response = await dio.get("/api/Classes");

  final data = response.data;

  print("CLASSES RESPONSE = $data");

  if (data is! List) return [];

  return data
      .where((e) => e is Map && e["id"] != null)
      .map<String>((e) => e["id"].toString())
      .toList();
});*/