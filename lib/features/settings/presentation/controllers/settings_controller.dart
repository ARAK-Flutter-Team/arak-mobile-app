/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../state/settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {

  SettingsController()
      : super(
    const SettingsState(
      messageNotification: true,
      attendanceAlert: true,
      darkMode: false,
    ),
  ) {
    loadSettings();
  }

  Future<void> loadSettings() async {

    final prefs = await SharedPreferences.getInstance();

    state = state.copyWith(
      messageNotification:
      prefs.getBool("messageNotification") ?? true,
      attendanceAlert:
      prefs.getBool("attendanceAlert") ?? true,
      darkMode:
      prefs.getBool("darkMode") ?? false,
    );
  }

  Future<void> toggleMessageNotification(bool value) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("messageNotification", value);

    state = state.copyWith(
      messageNotification: value,
    );
  }

  Future<void> toggleAttendanceAlert(bool value) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("attendanceAlert", value);

    state = state.copyWith(
      attendanceAlert: value,
    );
  }

  Future<void> toggleDarkMode(bool value) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("darkMode", value);

    state = state.copyWith(
      darkMode: value,
    );
  }
}*/
import 'package:arak_app/core/entities/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/providers/current_user_provider.dart';
import '../state/settings_state.dart';

class SettingsController extends StateNotifier<SettingsState> {
  final Ref ref;

  SettingsController(this.ref)
      : super(
          const SettingsState(
            messageNotification: true,
            attendanceAlert: true,
            darkMode: false,
          ),
        ) {
    loadSettings();
  }

  String get _roleKeySuffix {
    final user = ref.read(currentUserProvider);
    return user?.role == UserRole.teacher ? 'Teacher' : 'Parent';
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final user = ref.read(currentUserProvider);
    final userId = user?.id ?? '';
    final roleSuffix = _roleKeySuffix;

    state = state.copyWith(
      messageNotification: prefs.getBool("messageNotification_$userId") ?? true,
      attendanceAlert: prefs.getBool("attendanceAlert_$userId") ?? true,
      darkMode: prefs.getBool("is_dark_mode_$roleSuffix") ?? false,
    );
  }

  Future<void> toggleMessageNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final user = ref.read(currentUserProvider);
    final userId = user?.id ?? '';
    await prefs.setBool("messageNotification_$userId", value);
    state = state.copyWith(messageNotification: value);
  }

  Future<void> toggleAttendanceAlert(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final user = ref.read(currentUserProvider);
    final userId = user?.id ?? '';
    await prefs.setBool("attendanceAlert_$userId", value);
    state = state.copyWith(attendanceAlert: value);
  }

  Future<void> toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final roleSuffix = _roleKeySuffix;
    await prefs.setBool("is_dark_mode_$roleSuffix", value);
    state = state.copyWith(darkMode: value);
  }
}
