import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*final localeProvider = StateProvider<Locale>((ref) {
  //return const Locale('en'); // default
  return const Locale('ar');
});*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('ar')) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('lang') ?? 'ar';
    state = Locale(code);
  }

  Future<void> changeLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', code);
    state = Locale(code);
  }
}

final localeProvider =
StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});