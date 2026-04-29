/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.3:5000/api", // ✅ الـ IP الصح,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
<<<<<<< HEAD
});*/
/*import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioProvider {
  static const String _baseUrl = "http://192.168.1.9:5000";

  static Dio getDio() {
    final dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Content-Type": "application/json",
      },
    ));

    // Interceptor لإضافة التوكن تلقائياً في كل طلب
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }

        // إضافة print للتتبع
        print("REQUEST: ${options.method} ${options.uri}");
        return handler.next(options);
      },
      onError: (error, handler) {
        print("ERROR: ${error.response?.statusCode}");
        return handler.next(error);
      },
    ));

    // Logger عشان تشوفي الـ Response في الـ Console
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true));

    return dio;
  }
}

// Provider لاستخدام Dio في Riverpod
final dioProvider = Provider<Dio>((ref) => DioProvider.getDio());
*/
// ============================================================
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioProvider {
  static const String _baseUrl = "http://192.168.1.9:5000";

  static Dio getDio() {
    final dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        "Content-Type": "application/json",
      },
    ));

    // Interceptor لإضافة التوكن تلقائياً
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');

        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }

        print(" REQUEST: ${options.method} ${options.uri}");
        print(" Headers: ${options.headers}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print(
            " RESPONSE: ${response.statusCode} ${response.requestOptions.uri}");
        return handler.next(response);
      },
      onError: (error, handler) {
        print(" ERROR: ${error.response?.statusCode} - ${error.message}");
        if (error.response?.data != null) {
          print(" Error Data: ${error.response?.data}");
        }
        return handler.next(error);
      },
    ));

    // Pretty Logger للإطلاع على التفاصيل
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 90));

    return dio;
  }
}

final dioProvider = Provider<Dio>((ref) => DioProvider.getDio());
