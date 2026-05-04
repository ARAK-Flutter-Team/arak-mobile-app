import 'package:dio/dio.dart';
import '../config/app_config.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl, // رابط الكمبيوتر
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
