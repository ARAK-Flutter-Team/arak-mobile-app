import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(String baseUrl)
      : dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  void setToken(String token) {
    dio.options.headers["Authorization"] = "Bearer $token";
  }
}