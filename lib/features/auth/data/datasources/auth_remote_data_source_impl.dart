/*import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../../domain/params/login_params.dart';
import 'auth_remote_data_source.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(LoginParams params) async {
    // محاكاة طلب API
    await Future.delayed(const Duration(seconds: 1));

    // ------------------------------
    // جاهز للباك:
    /*
    final url = Uri.parse("https://example.com/api/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
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
      throw ServerException();
    }
    */
    // ------------------------------

    // البيانات الوهمية للتجربة
    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: params.email,
      role: UserRole.parent,
    );
  }

  @override
  Future<UserModel> getCurrentUser() async {
    // محاكاة طلب API
    await Future.delayed(const Duration(seconds: 1));

    // ------------------------------
    // جاهز للباك:
    /*
    final url = Uri.parse("https://example.com/api/me");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        // "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
    */
    // ------------------------------

    // البيانات الوهمية للتجربة
    return UserModel(
      id: 1,
      name: "Noha Mahmoud",
      email: "noha@example.com",
      role: UserRole.parent,
    );
  }
}
*/
import 'dart:convert';
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
}