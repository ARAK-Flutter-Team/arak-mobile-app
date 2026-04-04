// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String welcome(Object name) {
    return 'Welcome $name';
  }

  @override
  String get teacherPerformance => 'Teacher Performance';

  @override
  String get tasks => 'Tasks';

  @override
  String get messages => 'Messages';

  @override
  String get attendance => 'Attendance';

  @override
  String get schedule => 'Schedule';

  @override
  String get recentActivities => 'Recent Activities';

  @override
  String get noActivities => 'No activities yet';

  @override
  String get homeworkAdded => 'You assigned a new task';

  @override
  String get messageFromAdmin => 'New message from admin';

  @override
  String get studentPresent => 'Your child was marked present';
}
