/*import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(LoginParams params) async {

    final url = Uri.parse("https://example.com/api/login");

    final response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": params.email,
        "password": params.password,
        "role": params.role,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("Login Failed");
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {

    final url = Uri.parse("https://example.com/api/me");

    final response = await client.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception("User Not Found");
    }
  }
}*/
/*import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final http.Client client;

  final String baseUrl = "http://192.168.1.9:5000/api/auth";

  AuthRemoteDataSourceImpl({required this.client});

  String? _token;

  @override
  Future<UserModel> login(LoginParams params) async {

    final url = Uri.parse("$baseUrl/login");

    final response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": params.email,
        "password": params.password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {

      _token = data['token']; // خزني التوكن

      return UserModel.fromJson(data['user']);
    } else {
      throw Exception(data['message'] ?? "Login Failed");
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {

    final url = Uri.parse("$baseUrl/me");

    final response = await client.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token",
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(data['user']);
    } else {
      throw Exception("Unauthorized");
    }
  }
}*/
/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  final String baseUrl = "http://192.168.1.9:5000/api/auth";

  AuthRemoteDataSourceImpl({required this.client});

  // ===============================
  // LOGIN
  // ===============================
  @override
  Future<UserModel> login(LoginParams params) async {
    final url = Uri.parse("$baseUrl/login");

    try {
      final response = await client
          .post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": params.email,
          "password": params.password,
        }),
      )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = data['token'];

        //  تخزين التوكن
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException(data['message'] ?? "Login Failed");
      }
    } catch (e) {
      throw ServerException("Login error: $e");
    }
  }

  // ===============================
  // GET CURRENT USER
  // ===============================
  @override
  Future<UserModel> getCurrentUser() async {
    final url = Uri.parse("$baseUrl/me");

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw ServerException("No token found");
      }

      final response = await client
          .get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      )
          .timeout(const Duration(seconds: 10));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(data['user']);
      } else {
        throw ServerException(data['message'] ?? "Unauthorized");
      }
    } catch (e) {
      throw ServerException("Get user error: $e");
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

import '../../../../core/error/exceptions.dart';
import '../../domain/params/login_params.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  //final String baseUrl = "http://192.168.1.9:5000/api/Auth";
  //final String baseUrl = "/Auth";
  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> login(LoginParams params) async {
    try {
      print(" LOGIN REQUEST START");
     // print(" URL: $baseUrl/login");
      print(" Email: ${params.email}");

      /*final response = await dio.post(
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
      );*/
      final response = await dio.post(
        "/Auth/login",
        data: {
          "email": params.email,
          "password": params.password,
        },
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
      /*throw ServerException(
        e.response?.data?['message'] ?? e.message ?? "Login error",
      );*/
      final errorData = e.response?.data;

      String message;

      if (errorData is Map && errorData['message'] != null) {
        message = errorData['message'];
      } else {
        message = e.message ?? "Login error";
      }

      throw ServerException(message);
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

      /*final response = await dio.get(
        "$baseUrl/me",
        options: Options(
          /*headers: {
            "Authorization": "Bearer $token",
          },*/
        ),
      );*/
      final response = await dio.get("/Auth/me");
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
}