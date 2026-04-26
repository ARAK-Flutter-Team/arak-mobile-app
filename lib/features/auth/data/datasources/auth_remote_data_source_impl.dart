/*import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

<<<<<<< HEAD
  final String baseUrl = "http://192.168.1.9:5000/api/Auth";

=======
final String baseUrl = "http://192.168.1.9:5000/api/Auth";

  AuthRemoteDataSourceImpl({required this.dio});

  // ===============================
  // LOGIN
  // ===============================
  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      final response = await dio.post(
        "$baseUrl/login",
        data: {
          "email": params.email,
          "password": params.password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      final data = response.data;

      if (response.statusCode == 200) {
        final token = data['token'];

        // تخزين التوكن
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException(data['message'] ?? "Login Failed");
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] ?? "Login error",
      );
    }
  }

  // ===============================
  // GET CURRENT USER
  // ===============================
  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw ServerException("No token found");
      }

      final response = await dio.get(
        "$baseUrl/me",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      final data = response.data;

      if (response.statusCode == 200) {
        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException(data['message'] ?? "Unauthorized");
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] ?? "Get user error",
      );
    }
  }

  // ===============================
  // LOGOUT
  // ===============================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}*/
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.1.11:5000/api/Auth";

  AuthRemoteDataSourceImpl({required this.dio});

  // ======================
  // دالة مساعدة عشان نفك التوكن يدوياً (بدون مكتبات خارجية)
  // ======================
  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];

    String normalized = payload.replaceAll('-', '+').replaceAll('_', '/');

    switch (normalized.length % 4) {
      case 0:
        break;
      case 2:
        normalized += '==';
        break;
      case 3:
        normalized += '=';
        break;
    }

    final decodedBytes = base64.decode(normalized);
    final decodedString = utf8.decode(decodedBytes);

    return json.decode(decodedString) as Map<String, dynamic>;
  }

  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      print(" LOGIN REQUEST START");
      print(" URL: $baseUrl/login");
      print(" Email: ${params.email}");

      final response = await dio.post(
        "$baseUrl/login",
        data: {
          "email": params.email,
          "password": params.password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      print(" STATUS: ${response.statusCode}");
      print(" DATA: ${response.data}");

      final data = response.data;

      if (response.statusCode == 200) {
        final token = data['token'] ?? "";
        final userJson = data['user'] as Map<String, dynamic>;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        try {
          Map<String, dynamic> payload = _parseJwt(token);
          String userIdFromToken = payload['sub'];
          print(" User ID from Token: $userIdFromToken");
          userJson['id'] = userIdFromToken;
        } catch (e) {
          print(" Error decoding token: $e");
        }

        print(" LOGIN SUCCESS");

        return UserModel.fromLoginJson(userJson, token);
      } else {
        throw ServerException(data['message'] ?? "Login Failed");
      }
    } on DioException catch (e) {
      print(" Dio Error Type: ${e.type}");
      print(" Dio Error Message: ${e.message}");
      print(" Dio Response: ${e.response?.data}");

      throw ServerException(
        e.response?.data?['message'] ?? e.message ?? "Login error",
      );
    } catch (e) {
      print(" Unknown Error: $e");
      rethrow;
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw ServerException("No token found");
      }

      final response = await dio.get(
        "$baseUrl/me",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      final data = response.data;
      if (response.statusCode == 200) {
        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException("Unauthorized");
      }
    } on DioException catch (e) {
      print(" Dio Error Type: ${e.type}");
      print(" Dio Error Message: ${e.message}");
      print(" Dio Response: ${e.response?.data}");

      throw ServerException("Get user error");
    }
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

// ============================================================
/*

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl_Old implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.1.9:5000/api/Auth";

  AuthRemoteDataSourceImpl_Old({required this.dio});

  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      final response = await dio.post(
        "$baseUrl/login",
        data: {
          "email": params.email,
          "password": params.password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      final data = response.data;

      if (response.statusCode == 200) {
        final token = data['token'] ?? "";
        final userJson = data['user'] as Map<String, dynamic>;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        return UserModel.fromLoginJson(userJson, token);
      } else {
        throw ServerException(data['message'] ?? "Login Failed");
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data?['message'] ?? e.message ?? "Login error",
      );
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) throw ServerException("No token found");

      final response = await dio.get(
        "$baseUrl/me",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['user']);
      } else {
        throw ServerException("Unauthorized");
      }
    } on DioException catch (e) {
      throw ServerException("Get user error");
    }
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
*/
