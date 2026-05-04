// lib/features/conversations/data/repositories/conversation_repository_impl.dart
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../datasource/chat_remote_datasource.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Conversation>> getConversations() async {
    final models = await remoteDataSource.getConversations();
    return models;
  }

  @override
  Future<List<Message>> getMessages({
    required String userId,
    int page = 1,
    int pageSize = 50,
  }) async {
    final models = await remoteDataSource.getMessages(
      userId: userId,
      page: page,
      pageSize: pageSize,
    );
    return models;
  }

  @override
  Future<Message> sendMessage({
    required String senderId,
    required String receiverId,
    required String content,
  }) async {
    return await remoteDataSource.sendMessage(
      senderId: senderId,
      receiverId: receiverId,
      content: content,
    );
  }

  @override
  Future<void> markMessageAsRead({
    required String userId,
    required int messageId,
  }) async {
    await remoteDataSource.markMessageAsRead(
      userId: userId,
      messageId: messageId,
    );
  }

  @override
  Future<void> markAllMessagesAsRead({
    required String userId,
  }) async {
    await remoteDataSource.markAllMessagesAsRead(userId: userId);
  }
}