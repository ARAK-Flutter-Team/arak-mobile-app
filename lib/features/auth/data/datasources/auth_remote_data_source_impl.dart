import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../domain/usecases/login_params.dart';
import '../../../../core/error/exceptions.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  // نقدر نمرر الـ http client من DI container
  AuthRemoteDataSourceImpl({http.Client? client}) : client = client ?? http.Client();

  @override
  Future<UserModel> login(LoginParams params) async {
    // هنا تقدر تحطي رابط الـ API بتاعك
    final url = Uri.parse("https://example.com/api/login");

    try {
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
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}