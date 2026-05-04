import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../../shared/providers/shared_preferences_provider.dart';

class DioProvider {
  static const String _baseUrl = AppConfig.baseUrl;

  static Dio getDio(Ref ref) {
    final dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Use pre-initialized SharedPreferences synchronously
        final prefs = ref.read(sharedPreferencesProvider);
        final token = prefs.getString('token');

        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
          if (kDebugMode) {
            print(" Token added to request: ${options.method} ${options.uri}");
          }
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: false,
        maxWidth: 120,
      ));
    }

    return dio;
  }
}

final dioProvider = Provider<Dio>((ref) {
  return DioProvider.getDio(ref);
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
});

final tokenProvider = Provider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('token');
});