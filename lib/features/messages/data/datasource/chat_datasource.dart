import '../models/message_model.dart';

class ChatDatasource {

  final List<MessageModel> _messages = [];

  Future<List<MessageModel>> getMessages(
      String userId,
      String otherUserId,
      ) async {

    final messages = _messages.where((message) {

      return (message.senderId == userId &&
          message.receiverId == otherUserId) ||

          (message.senderId == otherUserId &&
              message.receiverId == userId);

    }).toList();

    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return messages;
  }

  Future<void> sendMessage(MessageModel message) async {

    _messages.add(message);
  }

  Future<void> deleteMessageForEveryone(String messageId) async {

    final index = _messages.indexWhere((m) => m.id == messageId);

    if (index != -1) {

      final old = _messages[index];

      _messages[index] = MessageModel(
        id: old.id,
        senderId: old.senderId,
        receiverId: old.receiverId,
        text: "This message was deleted",
        createdAt: old.createdAt,
        deletedForEveryone: true,
      );
    }
  }

  Future<void> deleteMessageForMe(String messageId) async {

    _messages.removeWhere((m) => m.id == messageId);
  }
}