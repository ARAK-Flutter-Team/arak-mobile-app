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

  String _getUserFriendlyMessage(DioException e) {
    if (e.response?.statusCode == 401) {
      return "Invalid email or password.";
    }
    if (e.response?.statusCode == 404) {
      return "Server error. Please contact support.";
    }
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "Connection timed out. Check your internet.";
    }
    if (e.type == DioExceptionType.connectionError) {
      return "No internet connection.";
    }
    return "Login failed. Please try again.";
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

      String userMessage = _getUserFriendlyMessage(e);
      throw ServerException(userMessage);
    } catch (e) {
      print(" Unknown Error: $e");
      throw ServerException("Something went wrong. Please try again.");
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
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null && token.isNotEmpty) {
        await dio.post(
          "$baseUrl/logout",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          ),
        );
        print(" Backend logout successful");
      } else {
        print("️ No token found, skipping backend logout");
      }
    } catch (e) {
      print(" Backend logout error: $e");
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      print(" Token removed from device");
    }
  }
}
