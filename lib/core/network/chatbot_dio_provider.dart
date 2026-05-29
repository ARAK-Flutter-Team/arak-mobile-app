import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../../shared/providers/shared_preferences_provider.dart';

final chatbotDioProvider = Provider<Dio>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  final token = prefs.getString('token') ?? '';

  return Dio(BaseOptions(
    baseUrl: AppConfig.chatbotUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  ));
});
