import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}