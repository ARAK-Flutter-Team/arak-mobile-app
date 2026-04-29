import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart'; // اختياري للتتبع

/*class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(BaseOptions(
      baseUrl: "http://192.168.1.9:5000", // رابط الباك اند
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    // إضافة Interceptor للـ Logging (اختياري)
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    // مهم: هنا تضيفي الـ Auth Interceptor لو عندك Token
    // dio.interceptors.add(AuthInterceptor());
  }

  // دالة مساعدة لتحديث الـ Token لو احتجتي
  void updateToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}*/
class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(BaseOptions(
      baseUrl: "http://192.168.1.11:5000", // رابط الكمبيوتر
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ));

    // ... (الـ Interceptors اللي عندك)
  }

  void updateToken(String token) {
    // نضيف التوكن في الهيدر تحت اسم Authorization
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
