import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}'**
  String welcome(Object name);

  /// No description provided for @teacherPerformance.
  ///
  /// In en, this message translates to:
  /// **'Teacher Performance'**
  String get teacherPerformance;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @recentActivities.
  ///
  /// In en, this message translates to:
  /// **'Recent Activities'**
  String get recentActivities;

  /// No description provided for @noActivities.
  ///
  /// In en, this message translates to:
  /// **'No activities yet'**
  String get noActivities;

  /// No description provided for @homeworkAdded.
  ///
  /// In en, this message translates to:
  /// **'You assigned a new task'**
  String get homeworkAdded;

  /// No description provided for @messageFromAdmin.
  ///
  /// In en, this message translates to:
  /// **'New message from admin'**
  String get messageFromAdmin;

  /// No description provided for @studentPresent.
  ///
  /// In en, this message translates to:
  /// **'Your child was marked present'**
  String get studentPresent;

  /// No description provided for @selectClass.
  ///
  /// In en, this message translates to:
  /// **'Select Class'**
  String get selectClass;

  /// No description provided for @addNewTask.
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addNewTask;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @noTasksFound.
  ///
  /// In en, this message translates to:
  /// **'No Tasks Found'**
  String get noTasksFound;

  /// No description provided for @lastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get lastUpdate;

  /// No description provided for @studentsSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Students Submitted'**
  String get studentsSubmitted;

  /// No description provided for @assignANewActivityOrHomeworkToYourStudents.
  ///
  /// In en, this message translates to:
  /// **'Assign a new activity or homework to your students.'**
  String get assignANewActivityOrHomeworkToYourStudents;

  /// No description provided for @errorLoadingClasses.
  ///
  /// In en, this message translates to:
  /// **'Error loading classes'**
  String get errorLoadingClasses;

  /// No description provided for @noClassesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No classes available'**
  String get noClassesAvailable;

  /// No description provided for @taskTitle.
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitle;

  /// No description provided for @enterTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter task title'**
  String get enterTaskTitle;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @writeTaskDescription.
  ///
  /// In en, this message translates to:
  /// **'Write task description'**
  String get writeTaskDescription;

  /// No description provided for @math.
  ///
  /// In en, this message translates to:
  /// **'Math'**
  String get math;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @myWeeklySchedule.
  ///
  /// In en, this message translates to:
  /// **'My Weekly Schedule'**
  String get myWeeklySchedule;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @attendanceSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Attendance saved successfully'**
  String get attendanceSavedSuccessfully;

  /// No description provided for @failedToSaveAttendance.
  ///
  /// In en, this message translates to:
  /// **'Failed to save attendance'**
  String get failedToSaveAttendance;

  /// No description provided for @overallAttendance.
  ///
  /// In en, this message translates to:
  /// **'Overall Attendance'**
  String get overallAttendance;

  /// No description provided for @saveAttendance.
  ///
  /// In en, this message translates to:
  /// **'Save Attendance'**
  String get saveAttendance;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @absent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get absent;

  /// No description provided for @classLabel.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get classLabel;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessages;

  /// No description provided for @parent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get parent;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording...'**
  String get recording;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type message...'**
  String get typeMessage;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyDescription.
  ///
  /// In en, this message translates to:
  /// **'Your privacy is important to us. This policy explains how we collect and use your information.'**
  String get privacyDescription;

  /// No description provided for @infoCollected.
  ///
  /// In en, this message translates to:
  /// **'Information We Collect'**
  String get infoCollected;

  /// No description provided for @infoCollectedDesc.
  ///
  /// In en, this message translates to:
  /// **'We may collect basic information such as your name, profile image and academic data to provide educational services.'**
  String get infoCollectedDesc;

  /// No description provided for @howWeUse.
  ///
  /// In en, this message translates to:
  /// **'How We Use Your Information'**
  String get howWeUse;

  /// No description provided for @howWeUseDesc.
  ///
  /// In en, this message translates to:
  /// **'The collected data is used to provide features like messaging, attendance alerts and personalized academic services.'**
  String get howWeUseDesc;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @notificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Users can control message and attendance notifications through the settings page.'**
  String get notificationsDesc;

  /// No description provided for @dataSecurity.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get dataSecurity;

  /// No description provided for @dataSecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'We take appropriate measures to ensure that user information remains protected and secure.'**
  String get dataSecurityDesc;

  /// No description provided for @policyUpdates.
  ///
  /// In en, this message translates to:
  /// **'Policy Updates'**
  String get policyUpdates;

  /// No description provided for @policyUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'This privacy policy may change occasionally and users will be notified through the application.'**
  String get policyUpdatesDesc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @messageNotification.
  ///
  /// In en, this message translates to:
  /// **'Message Notification'**
  String get messageNotification;

  /// No description provided for @attendanceAlerts.
  ///
  /// In en, this message translates to:
  /// **'Attendance Alerts'**
  String get attendanceAlerts;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @messageEnabled.
  ///
  /// In en, this message translates to:
  /// **'Message notifications enabled'**
  String get messageEnabled;

  /// No description provided for @messageDisabled.
  ///
  /// In en, this message translates to:
  /// **'Message notifications disabled'**
  String get messageDisabled;

  /// No description provided for @attendanceEnabled.
  ///
  /// In en, this message translates to:
  /// **'Attendance alerts enabled'**
  String get attendanceEnabled;

  /// No description provided for @attendanceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Attendance alerts disabled'**
  String get attendanceDisabled;

  /// No description provided for @darkModeEnabled.
  ///
  /// In en, this message translates to:
  /// **'Dark mode enabled'**
  String get darkModeEnabled;

  /// No description provided for @darkModeDisabled.
  ///
  /// In en, this message translates to:
  /// **'Dark mode disabled'**
  String get darkModeDisabled;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notifications'**
  String get noNotifications;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @earlier.
  ///
  /// In en, this message translates to:
  /// **'Earlier'**
  String get earlier;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @teacherInformation.
  ///
  /// In en, this message translates to:
  /// **'Teacher Information'**
  String get teacherInformation;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountType;

  /// No description provided for @admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get admin;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @assignTask.
  ///
  /// In en, this message translates to:
  /// **'Assign Task'**
  String get assignTask;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search students, tasks...'**
  String get searchHint;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'This task has been cancelled'**
  String get taskDeleted;

  /// No description provided for @taskAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Task added successfully'**
  String get taskAddedSuccessfully;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @deleteForMe.
  ///
  /// In en, this message translates to:
  /// **'Delete for me'**
  String get deleteForMe;

  /// No description provided for @deleteForEveryone.
  ///
  /// In en, this message translates to:
  /// **'Delete for everyone'**
  String get deleteForEveryone;

  /// No description provided for @checkStatus.
  ///
  /// In en, this message translates to:
  /// **'Check Status'**
  String get checkStatus;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Task?'**
  String get confirmDelete;

  /// No description provided for @deleteTaskMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteTaskMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @noClassesFound.
  ///
  /// In en, this message translates to:
  /// **'No classes found'**
  String get noClassesFound;

  /// No description provided for @noScheduleFound.
  ///
  /// In en, this message translates to:
  /// **'No schedule found for the selected filters'**
  String get noScheduleFound;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @activeFilters.
  ///
  /// In en, this message translates to:
  /// **'Active Filters:'**
  String get activeFilters;

  /// No description provided for @teacherLabel.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacherLabel;

  /// No description provided for @filterSchedule.
  ///
  /// In en, this message translates to:
  /// **'Filter Schedule'**
  String get filterSchedule;

  /// No description provided for @enterClassId.
  ///
  /// In en, this message translates to:
  /// **'Enter class ID'**
  String get enterClassId;

  /// No description provided for @enterTeacherId.
  ///
  /// In en, this message translates to:
  /// **'Enter teacher ID'**
  String get enterTeacherId;

  /// No description provided for @applyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get applyFilters;

  /// No description provided for @mySchedule.
  ///
  /// In en, this message translates to:
  /// **'My Schedule'**
  String get mySchedule;

  /// No description provided for @studentInformation.
  ///
  /// In en, this message translates to:
  /// **'Student Information'**
  String get studentInformation;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @className.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get className;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @evaluation.
  ///
  /// In en, this message translates to:
  /// **'Evaluation'**
  String get evaluation;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUs;

  /// No description provided for @foxChatbot.
  ///
  /// In en, this message translates to:
  /// **'Fox chatbot'**
  String get foxChatbot;

  /// No description provided for @studentName.
  ///
  /// In en, this message translates to:
  /// **'Student Name'**
  String get studentName;

  /// No description provided for @studentGrade.
  ///
  /// In en, this message translates to:
  /// **'Student Grade'**
  String get studentGrade;
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
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
