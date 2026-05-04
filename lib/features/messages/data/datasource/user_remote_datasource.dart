import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/logger_utils.dart';
import '../models/user_model.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  /// البحث عن مستخدم بالبريد الإلكتروني (Exact Match حسب الباك)
  Future<List<UserModel>> searchUsers(String email) async {
    try {
      if (email.isEmpty) return [];

      final url = ApiConstants.searchUsers(email);
      AppLogger.logInfo('🔎 [API] Searching users: $url');

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw Exception('Access Denied: Only Admins can search.');
      }
      throw Exception('Error searching users: ${e.message}');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final url = ApiConstants.getUsers();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } on DioException catch (e) {
      throw Exception('Error loading users: ${e.message}');
    }
  }
}