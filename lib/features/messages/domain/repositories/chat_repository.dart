import '../entities/message.dart';

abstract class ChatRepository {

  Future<List<Message>> getMessages(
      String currentUserId,
      String otherUserId,
      );

  Future<void> sendMessage(Message message);

  Future<void> deleteMessageForEveryone(String messageId);

  Future<void> deleteMessageForMe(String messageId);
}