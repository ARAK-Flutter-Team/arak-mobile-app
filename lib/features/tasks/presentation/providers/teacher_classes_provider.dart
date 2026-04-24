import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/network/dio_provider.dart';

final teacherClassesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, teacherId) async {
    final dio = ref.read(dioProvider);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await dio.get(
      "/api/classes",
      queryParameters: {"teacherId": int.tryParse(teacherId) ?? 0},
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty)
            "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.data is! List) return [];

    return (response.data as List)
        .where((e) => e is Map && e["id"] != null)
        .map<Map<String, dynamic>>((e) {
          final c = Map<String, dynamic>.from(e as Map);
          return {
            "id": c["id"],
            "name": c["name"]?.toString() ?? c["id"].toString(),
          };
        })
        .toList();
  },
);
