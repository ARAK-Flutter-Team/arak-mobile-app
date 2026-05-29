import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/chatbot_dio_provider.dart';

class ChatbotRemoteDatasource {
  final Dio _dio;
  ChatbotRemoteDatasource(this._dio);

  Future<String> sendMessage(String message) async {
    try {
      final response = await _dio.post('/chat', data: {'message': message});
      return response.data['reply'] as String;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return 'انتهت صلاحية الجلسة، من فضلك سجل الدخول مرة أخرى.';
      }
      return 'حدث خطأ في الاتصال، حاول مرة أخرى.';
    }
  }
}

final chatbotDatasourceProvider = Provider<ChatbotRemoteDatasource>((ref) {
  final dio = ref.read(chatbotDioProvider);
  return ChatbotRemoteDatasource(dio);
});
