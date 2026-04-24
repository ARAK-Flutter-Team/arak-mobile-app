/*import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  final String baseUrl = "http://192.168.1.9:5000/api/Auth";

  AuthRemoteDataSourceImpl({required this.dio});

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
        //final token = data['token'];
        final token = data['token'] ?? "";
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print(" LOGIN SUCCESS");

        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException(data['message'] ?? "Login Failed");
      }
    } on DioException catch (e) {
      print(" Dio Error Type: ${e.type}");
      print(" Dio Error Message: ${e.message}");
      print(" Dio Response: ${e.response?.data}");
      print(" Dio Status Code: ${e.response?.statusCode}");
      print(" Dio Data: ${e.response?.data}");
      //throw ServerException("Login error");
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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}*/
/*import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  // استخدام الرابط الصحيح
  final String baseUrl = "http://192.168.1.9:5000/api/Auth";

  AuthRemoteDataSourceImpl({required this.dio});

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

        // حفظ التوكن محلياً (اختياري عشان Auto Login)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        print(" LOGIN SUCCESS");

        // ⚠️ التعديل: استخدام fromLoginJson لتمرير التوكن للـ User
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
        // عشان getCurrentUser التوكن موجود برضه في الـ user
        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException("Unauthorized");
      }
    } on DioException catch (e) {
      throw ServerException("Get user error");
    }
  }
}*/
/*import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart'; // مكتبة فك التوكن

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.1.9:5000/api/Auth";

  AuthRemoteDataSourceImpl({required this.dio});

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

        // 1. حفظ التوكن في SharedPrefs
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // 2. استخراج الـ ID من التوكن
        try {
          //  التصحيح هنا: استخدام دالة jwtDecode مباشرة
          Map<String, dynamic> payload = JwtDecoder.parseJwt(token);
          // الـ ID موجود في 'sub'
          String userIdFromToken = payload['sub'];

          print(" User ID from Token: $userIdFromToken");

          // تحذير: الـ ID هنا هو String (GUID)، بينما الـ User Entity ينتظر Int.
          // لو عملت السطر ده، ممكن يحصل Error في النوع.
          // userJson['id'] = userIdFromToken;

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
}*/
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ⚠️ شيلنا مكتبة jwt_decode وهنستخدم Dart الأساسية
import 'dart:convert'; // لاستخدام base64 و json

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl = "http://192.168.1.9:5000/api/Auth";

  AuthRemoteDataSourceImpl({required this.dio});

  // ======================
  // دالة مساعدة عشان نفك التوكن يدوياً (بدون مكتبات خارجية)
  // ======================
  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    // الجزء الأوسط هو الـ Payload
    final payload = parts[1];

    // تنظيف الـ Base64 String (استبدال - و _ بـ + و /)
    String normalized = payload.replaceAll('-', '+').replaceAll('_', '/');

    // إضافة Padding عشان طول الـ String يكون مضبوط
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

    // فك التشفير
    final decodedBytes = base64.decode(normalized);
    final decodedString = utf8.decode(decodedBytes);

    // تحويل لـ Map
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

        // 1. حفظ التوكن في SharedPrefs
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // ⚠️ 2. استخراج الـ ID من التوكن باستخدام الدالة اللي فوق
        try {
          Map<String, dynamic> payload = _parseJwt(token);

          // الـ ID موجود في 'sub'
          String userIdFromToken = payload['sub'];

          print(" User ID from Token: $userIdFromToken");

          // ✅ هنا نحدث الـ ID في الـ userJson
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