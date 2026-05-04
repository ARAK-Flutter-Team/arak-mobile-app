import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';

class DioProvider {
  static const String _baseUrl = AppConfig.baseUrl;

  static Dio getDio() {
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
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
          if (kDebugMode) {
            print(" Token added to request: ${options.method} ${options.uri}");
          }
        } else {
          if (kDebugMode) {
            print("️ No token found for request: ${options.method} ${options.uri}");
          }
        }

        if (kDebugMode) {
          print(" REQUEST: ${options.method} ${options.uri}");
          print(" Headers: ${options.headers}");
          if (options.data != null) {
            print(" Body: ${options.data}");
          }
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (kDebugMode) {
          print(" RESPONSE: ${response.statusCode} ${response.requestOptions.uri}");
          print(" Response data: ${response.data}");
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        if (kDebugMode) {
          print(" DIO ERROR:");
          print("   Status Code: ${error.response?.statusCode}");
          print("   Message: ${error.message}");
          print("   URI: ${error.requestOptions.uri}");
          if (error.response?.data != null) {
            print("   Error Data: ${error.response?.data}");
          }
          if (error.type == DioExceptionType.connectionTimeout) {
            print("    Connection timeout - server might be down");
          } else if (error.type == DioExceptionType.receiveTimeout) {
            print("    Receive timeout - server not responding");
          } else if (error.type == DioExceptionType.connectionError) {
            print("    Connection error - check your network");
          }
        }
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
  return DioProvider.getDio();
});

final isAuthenticatedProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token != null && token.isNotEmpty;
});

final tokenProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
});