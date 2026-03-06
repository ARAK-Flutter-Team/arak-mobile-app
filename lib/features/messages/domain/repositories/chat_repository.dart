import '../entities/message.dart';
import '../enums/user_status.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(String currentUserId, String otherUserId);
  Stream<List<Message>> listenMessages(String currentUserId, String otherUserId);
  Future<void> sendMessage(Message message);
  Future<void> deleteMessageForMe(String messageId);
  Future<void> deleteMessageForEveryone(String messageId);
  Future<void> markAsSeen(String messageId);
  Future<void> updateUserStatus(String userId, UserStatus status);
}