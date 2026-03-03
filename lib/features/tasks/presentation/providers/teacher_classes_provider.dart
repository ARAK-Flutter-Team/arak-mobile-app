import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ===========================
/// Provider لجلب الكلاسات الخاصة بالمدرس
/// ===========================

final teacherClassesProvider =
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
});