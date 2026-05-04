// lib/features/conversations/data/datasources/conversation_remote_datasource.dart
/*import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/logger_utils.dart';
import '../models/message_model.dart';
import '../models/conversation_model.dart';

class ConversationRemoteDataSource {
  final Dio dio;

  ConversationRemoteDataSource(this.dio);

  /// جلب قائمة المحادثات
  Future<List<ConversationModel>> getConversations() async {
    try {
      final url = ApiConstants.getConversations();
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] GET Conversations');
      AppLogger.logInfo('📍 URL: $url');

      final response = await dio.get(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');
      AppLogger.logInfo('📦 [DATA] ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        AppLogger.logInfo('✅ Found ${data.length} conversations');
        return data.map((json) => ConversationModel.fromJson(json)).toList();
      } else {
        AppLogger.logError('❌ Failed to load conversations: ${response.statusCode}');
        throw Exception('Failed to load conversations');
      }
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in getConversations', error: e);
      throw _handleDioError(e);
    }
  }

  /// جلب رسائل المحادثة
  Future<List<MessageModel>> getMessages({
    required String userId,
    required int page,
    required int pageSize,
  }) async {
    try {
      final url = ApiConstants.getMessages(userId, page: page, pageSize: pageSize);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] GET Messages');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 User ID: $userId');
      AppLogger.logInfo('📄 Page: $page, PageSize: $pageSize');

      final response = await dio.get(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');
      AppLogger.logInfo('📦 [DATA RAW] ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        AppLogger.logInfo('✅ Got ${data.length} messages from API');

        // طباعة تفاصيل كل رسالة
        for (var i = 0; i < data.length; i++) {
          final msg = data[i];
          AppLogger.logInfo('   📨 Message $i: id=${msg['id']}, sender=${msg['senderId']}, receiver=${msg['receiverId']}, content=${msg['content']}');
        }

        return data.map((json) => MessageModel.fromJson(json)).toList();
      } else {
        AppLogger.logError('❌ Failed to load messages: ${response.statusCode}');
        throw Exception('Failed to load messages');
      }
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in getMessages', error: e);
      throw _handleDioError(e);
    }
  }

  /// إرسال رسالة
  Future<MessageModel> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      final url = ApiConstants.sendMessage(receiverId);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] POST Send Message');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 Sender ID: $senderId (from Token)');
      AppLogger.logInfo('👤 Receiver ID: $receiverId (in URL)');
      AppLogger.logInfo('📝 Content: $content');

      final response = await dio.post(
        url,
        data: jsonEncode({'content': content}),
      );

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');
      AppLogger.logInfo('📦 [DATA] ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final message = MessageModel.fromJson(response.data);
        AppLogger.logInfo('✅ Message sent successfully!');
        AppLogger.logInfo('   📨 Message ID: ${message.id}');
        AppLogger.logInfo('   👤 Sender: ${message.senderName} (${message.senderId})');
        AppLogger.logInfo('   👤 Receiver: ${message.receiverName} (${message.receiverId})');
        AppLogger.logInfo('   📝 Content: ${message.content}');
        AppLogger.logInfo('   ⏰ Sent at: ${message.sentAt}');
        return message;
      } else {
        AppLogger.logError('❌ Failed to send message: ${response.statusCode}');
        throw Exception('Failed to send message');
      }
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in sendMessage', error: e);
      throw _handleDioError(e);
    }
  }

  /// تحديث رسالة كمقروءة
  Future<void> markMessageAsRead({
    required String userId,
    required int messageId,
  }) async {
    try {
      final url = ApiConstants.markMessageAsRead(userId, messageId);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] PATCH Mark Message Read');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 User ID: $userId');
      AppLogger.logInfo('📨 Message ID: $messageId');

      final response = await dio.patch(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');

      if (response.statusCode != 200) {
        AppLogger.logError('❌ Failed to mark message as read: ${response.statusCode}');
        throw Exception('Failed to mark message as read');
      }

      AppLogger.logInfo('✅ Message $messageId marked as read');
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in markMessageAsRead', error: e);
      throw _handleDioError(e);
    }
  }

  /// تحديث كل الرسائل كمقروءة
  Future<void> markAllMessagesAsRead({required String userId}) async {
    try {
      final url = ApiConstants.markAllAsRead(userId);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] PATCH Mark All Messages Read');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 User ID: $userId');

      final response = await dio.patch(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');

      if (response.statusCode != 200) {
        AppLogger.logError('❌ Failed to mark all messages as read: ${response.statusCode}');
        throw Exception('Failed to mark all messages as read');
      }

      AppLogger.logInfo('✅ All messages marked as read for user $userId');
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in markAllMessagesAsRead', error: e);
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    String message;
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      message = 'Network error: Check your connection';
    } else if (error.response?.statusCode == 401) {
      message = 'Authentication failed. Please login again.';
    } else if (error.response?.statusCode == 403) {
      message = 'You do not have permission to perform this action';
    } else if (error.response?.statusCode == 404) {
      message = 'Resource not found';
    } else if (error.response?.statusCode == 500) {
      message = 'Server error. Please try again later.';
    } else {
      message = 'Server error: ${error.message}';
    }
    AppLogger.logError('❌ Dio Error: $message', error: error);
    return Exception(message);
  }
}*/
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/logger_utils.dart';
import '../models/message_model.dart';
import '../models/conversation_model.dart';

class ConversationRemoteDataSource {
  final Dio dio;

  ConversationRemoteDataSource(this.dio);

  /// جلب قائمة المحادثات
  Future<List<ConversationModel>> getConversations() async {
    try {
      final url = ApiConstants.getConversations();
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] GET Conversations');
      AppLogger.logInfo('📍 URL: $url');

      final response = await dio.get(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');
      AppLogger.logInfo('📦 [DATA] ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        AppLogger.logInfo('✅ Found ${data.length} conversations');
        return data.map((json) => ConversationModel.fromJson(json)).toList();
      } else {
        AppLogger.logError('❌ Failed to load conversations: ${response.statusCode}');
        throw Exception('Failed to load conversations');
      }
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in getConversations', error: e);
      throw _handleDioError(e);
    }
  }

  /// جلب رسائل المحادثة
  /// [userId] يجب أن يكون ID الشخص التاني في المحادثة
  Future<List<MessageModel>> getMessages({
    required String userId,  // ID الشخص التاني (مثال: John = 380bb24e...)
    required int page,
    required int pageSize,
  }) async {
    try {
      final url = ApiConstants.getMessages(userId, page: page, pageSize: pageSize);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] GET Messages');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 Other User ID (in URL): $userId');
      AppLogger.logInfo('📄 Page: $page, PageSize: $pageSize');

      final response = await dio.get(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');
      AppLogger.logInfo('📦 [DATA RAW] ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        AppLogger.logInfo('✅ Got ${data.length} messages from API');

        // طباعة تفاصيل كل رسالة
        for (var i = 0; i < data.length; i++) {
          final msg = data[i];
          AppLogger.logInfo('   📨 Message $i: id=${msg['id']}, sender=${msg['senderId']}, receiver=${msg['receiverId']}, content=${msg['content']}');
        }

        return data.map((json) => MessageModel.fromJson(json)).toList();
      } else {
        AppLogger.logError('❌ Failed to load messages: ${response.statusCode}');
        throw Exception('Failed to load messages');
      }
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in getMessages', error: e);
      throw _handleDioError(e);
    }
  }

  /// إرسال رسالة
  Future<MessageModel> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    try {
      final url = ApiConstants.sendMessage(receiverId);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] POST Send Message');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 Sender ID: $senderId (from Token)');
      AppLogger.logInfo('👤 Receiver ID: $receiverId (in URL)');
      AppLogger.logInfo('📝 Content: $content');

      final response = await dio.post(
        url,
        data: jsonEncode({'content': content}),
      );

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');
      AppLogger.logInfo('📦 [DATA] ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final message = MessageModel.fromJson(response.data);
        AppLogger.logInfo('✅ Message sent successfully!');
        AppLogger.logInfo('   📨 Message ID: ${message.id}');
        AppLogger.logInfo('   👤 Sender: ${message.senderName} (${message.senderId})');
        AppLogger.logInfo('   👤 Receiver: ${message.receiverName} (${message.receiverId})');
        AppLogger.logInfo('   📝 Content: ${message.content}');
        AppLogger.logInfo('   ⏰ Sent at: ${message.sentAt}');
        return message;
      } else {
        AppLogger.logError('❌ Failed to send message: ${response.statusCode}');
        throw Exception('Failed to send message');
      }
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in sendMessage', error: e);
      throw _handleDioError(e);
    }
  }

  /// تحديث رسالة كمقروءة
  Future<void> markMessageAsRead({
    required String userId,
    required int messageId,
  }) async {
    try {
      final url = ApiConstants.markMessageAsRead(userId, messageId);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] PATCH Mark Message Read');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 User ID: $userId');
      AppLogger.logInfo('📨 Message ID: $messageId');

      final response = await dio.patch(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');

      if (response.statusCode != 200) {
        AppLogger.logError('❌ Failed to mark message as read: ${response.statusCode}');
        throw Exception('Failed to mark message as read');
      }

      AppLogger.logInfo('✅ Message $messageId marked as read');
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in markMessageAsRead', error: e);
      throw _handleDioError(e);
    }
  }

  /// تحديث كل الرسائل كمقروءة
  Future<void> markAllMessagesAsRead({required String userId}) async {
    try {
      final url = ApiConstants.markAllAsRead(userId);
      AppLogger.logInfo('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
      AppLogger.logInfo('📞 [API CALL] PATCH Mark All Messages Read');
      AppLogger.logInfo('📍 URL: $url');
      AppLogger.logInfo('👤 User ID: $userId');

      final response = await dio.patch(url);

      AppLogger.logInfo('📥 [RESPONSE] Status: ${response.statusCode}');

      if (response.statusCode != 200) {
        AppLogger.logError('❌ Failed to mark all messages as read: ${response.statusCode}');
        throw Exception('Failed to mark all messages as read');
      }

      AppLogger.logInfo('✅ All messages marked as read for user $userId');
    } on DioException catch (e) {
      AppLogger.logError('❌ Dio error in markAllMessagesAsRead', error: e);
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException error) {
    String message;
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      message = 'Network error: Check your connection';
    } else if (error.response?.statusCode == 401) {
      message = 'Authentication failed. Please login again.';
    } else if (error.response?.statusCode == 403) {
      message = 'You do not have permission to perform this action';
    } else if (error.response?.statusCode == 404) {
      message = 'Resource not found';
    } else if (error.response?.statusCode == 500) {
      message = 'Server error. Please try again later.';
    } else {
      message = 'Server error: ${error.message}';
    }
    AppLogger.logError('❌ Dio Error: $message', error: error);
    return Exception(message);
  }
}