import 'package:flutter_riverpod/flutter_riverpod.dart';
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
});
