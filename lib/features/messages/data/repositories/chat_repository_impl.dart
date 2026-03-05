import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasource/chat_datasource.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {

  final ChatDatasource datasource;

  ChatRepositoryImpl(this.datasource);

  @override
  Future<List<Message>> getMessages(
      String currentUserId,
      String otherUserId,
      ) async {

    final result =
    await datasource.getMessages(currentUserId, otherUserId);

    return result;
  }

  @override
  Future<void> sendMessage(Message message) async {

    final model = MessageModel.fromEntity(message);

    await datasource.sendMessage(model);
  }

  @override
  Future<void> deleteMessageForEveryone(String messageId) {

    return datasource.deleteMessageForEveryone(messageId);
  }

  @override
  Future<void> deleteMessageForMe(String messageId) {

    return datasource.deleteMessageForMe(messageId);
  }
}