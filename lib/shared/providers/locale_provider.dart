import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/entities/user.dart';
import 'current_user_provider.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  final Ref _ref;
  static const String _defaultKey = 'lang_global';

  LocaleNotifier(this._ref) : super(const Locale('ar')) {
    _init();
  }

  void _init() {
    // Listen to user changes to reload locale automatically
    _ref.listen<User?>(currentUserProvider, (previous, next) {
      _loadLocale(next);
    });
    
    // Initial load
    final user = _ref.read(currentUserProvider);
    _loadLocale(user);
  }

  String _getStorageKey(User? user) {
    if (user == null) return _defaultKey;
    final role = user.role.name;
    // Use teacherId for teachers if available, otherwise id
    final id = (user.role == UserRole.teacher ? user.teacherId : user.id) ?? 'unknown';
    return 'lang_${role}_$id';
  }

  Future<void> _loadLocale(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _getStorageKey(user);
    final code = prefs.getString(key) ?? prefs.getString(_defaultKey) ?? 'ar';
    state = Locale(code);
  }

  Future<void> changeLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    final user = _ref.read(currentUserProvider);
    final key = _getStorageKey(user);
    
    await prefs.setString(key, code);
    
    // If user is logged in, also update global default for future logins/guest sessions
    if (user != null) {
      await prefs.setString(_defaultKey, code);
    }
    
    state = Locale(code);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref);
});