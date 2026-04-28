import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
  <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar')
  ];

  // ==================== Existing Keys ====================
  String welcome(Object name);
  String get teacherPerformance;
  String get tasks;
  String get messages;
  String get attendance;
  String get schedule;
  String get recentActivities;
  String get noActivities;
  String get homeworkAdded;
  String get messageFromAdmin;
  String get studentPresent;
  String get selectClass;
  String get addNewTask;
  String get subject;
  String get deadline;
  String get selectDate;
  String get noTasksFound;
  String get lastUpdate;
  String get studentsSubmitted;
  String get assignANewActivityOrHomeworkToYourStudents;
  String get errorLoadingClasses;
  String get noClassesAvailable;
  String get taskTitle;
  String get enterTaskTitle;
  String get description;
  String get writeTaskDescription;
  String get math;
  String get science;
  String get english;
  String get myWeeklySchedule;
  String get sunday;
  String get monday;
  String get tuesday;
  String get wednesday;
  String get thursday;
  String get friday;
  String get saturday;
  String get attendanceSavedSuccessfully;
  String get failedToSaveAttendance;
  String get overallAttendance;
  String get saveAttendance;
  String get present;
  String get late;
  String get absent;
  String get classLabel;
  String get morning;
  String get evening;
  String get noMessages;
  String get parent;
  String get teacher;
  String get recording;
  String get typeMessage;
  String get privacyPolicy;
  String get privacyDescription;
  String get infoCollected;
  String get infoCollectedDesc;
  String get howWeUse;
  String get howWeUseDesc;
  String get notifications;
  String get notificationsDesc;
  String get dataSecurity;
  String get dataSecurityDesc;
  String get policyUpdates;
  String get policyUpdatesDesc;
  String get settings;
  String get messageNotification;
  String get attendanceAlerts;
  String get darkMode;
  String get messageEnabled;
  String get messageDisabled;
  String get attendanceEnabled;
  String get attendanceDisabled;
  String get darkModeEnabled;
  String get darkModeDisabled;
  String get language;
  String get noNotifications;
  String get recent;
  String get clearAll;
  String get today;
  String get yesterday;
  String get earlier;
  String get profile;
  String get personalInformation;
  String get teacherInformation;
  String get email;
  String get phone;
  String get username;
  String get accountType;
  String get admin;
  String get confirmLogout;
  String get logoutMessage;
  String get cancel;
  String get logout;
  String get assignTask;
  String get search;
  String get searchHint;
  String get noResultsFound;
  String get chooseLanguage;
  String get taskDeleted;
  String get taskAddedSuccessfully;
  String get chooseFromGallery;
  String get takePhoto;
  String get file;
  String get camera;
  String get deleteForMe;
  String get deleteForEveryone;
  String get checkStatus;
  String get confirmDelete;
  String get deleteTaskMessage;
  String get delete;
  String get done;
  String get pending;
  String get save;
  String get savedSuccessfully;
  String get noClassesFound;
  String get noScheduleFound;
  String get tryAgain;
  String get clearFilters;
  String get activeFilters;
  String get teacherLabel;
  String get filterSchedule;
  String get enterClassId;
  String get enterTeacherId;
  String get applyFilters;
  String get mySchedule;
  String get taskDetails;
  String get className;

  // ==================== Colleague's Keys (from upstream) ====================
  String get studentInformation;
  String get name;
  String get grade;
  String get more;
  String get evaluation;
  String get contactUs;
  String get foxChatbot;
  String get studentName;
  String get studentGrade;
  String get parentTasksTitle;
  String get parentTasksSubtitle;
  String get viewReports;
  String get taskStatusInProgress;
  String get taskStatusNotStarted;
  String get parentTaskViewOnly;
  String get checkIn;
  String get checkOut;
  String get attendanceRate;
  String get overallPerformance;
  String get searchStudent;
  String get searchByName;
  String get noStudentFound;
  String get attendanceDetails;
  String get attendanceCalendar;
  String lastUpdated(Object time);
  String get schoolSchedule;
  String get daily;
  String get weekly;
  String get downloadFullSchedule;
  String get subjects;
  String get downloadReport;
  String get downloading;
  String get reportDownloaded;
  String get writeYourMessage;
  String get typeYourMessage;
  String get ourSocialMedia;
  String couldNotLaunch(Object url);

  // ==================== Your New Keys (from stash) ====================
  String get parentTaskNote;
  String get error;
  String get pleaseSelectClass;
  String get pleaseSelectDeadline;
  String get errorOccurred;
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale".');
}