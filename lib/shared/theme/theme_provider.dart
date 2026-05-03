import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/current_user_provider.dart';
import '../../core/entities/user.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  // Watch currentUserProvider to recreate notifier and reload theme on login/logout
  ref.watch(currentUserProvider);
  return ThemeNotifier(ref);
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;
  ThemeNotifier(this._ref) : super(ThemeMode.light) {
    _loadTheme();
  }

  String get _roleKey {
    final user = _ref.read(currentUserProvider);
    final roleStr = user?.role == UserRole.teacher ? 'Teacher' : 'Parent';
    return 'is_dark_mode_$roleStr';
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_roleKey) ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleDarkMode(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_roleKey, isDark);
  }
}
