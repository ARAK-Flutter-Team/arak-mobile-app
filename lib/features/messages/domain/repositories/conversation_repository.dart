// lib/features/conversations/domain/repositories/conversation_repository.dart
import '../entities/conversation.dart';
import '../entities/message.dart';

abstract class ConversationRepository {
  Future<List<Conversation>> getConversations();

  Future<List<Message>> getMessages({
    required String userId,
    int page = 1,
    int pageSize = 50,
  });

  Future<Message> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  });

  Future<void> markMessageAsRead({
    required String userId,
    required int messageId,
  });

  Future<void> markAllMessagesAsRead({
    required String userId,
  });
}
