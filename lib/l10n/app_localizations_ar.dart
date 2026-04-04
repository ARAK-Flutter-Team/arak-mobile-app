// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String welcome(Object name) {
    return 'مرحباً $name';
  }

  @override
  String get teacherPerformance => 'أداء المعلم';

  @override
  String get tasks => 'المهام';

  @override
  String get messages => 'الرسائل';

  @override
  String get attendance => 'الحضور';

  @override
  String get schedule => 'الجدول';

  @override
  String get recentActivities => 'النشاطات الأخيرة';

  @override
  String get noActivities => 'لا يوجد نشاطات حالياً';

  @override
  String get homeworkAdded => 'تم تعيين واجب جديد';

  @override
  String get messageFromAdmin => 'رسالة جديدة من الإدارة';

  @override
  String get studentPresent => 'تم تسجيل حضور ابنك';
}
