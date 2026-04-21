import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider((ref) {
  return Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.9:5000",
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
});