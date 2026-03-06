import '../../domain/entities/message.dart';
import '../../domain/enums/user_status.dart';
import '../../domain/repositories/chat_repository.dart';

import '../datasource/chat_remote_datasource.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {

  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Message>> getMessages(
      String currentUserId,
      String otherUserId,
      ) async {

    return await remoteDataSource.getMessages(
      currentUserId,
      otherUserId,
    );
  }

  @override
  Future<void> sendMessage(Message message) async {

    final model = MessageModel(
      id: message.id,
      senderId: message.senderId,
      receiverId: message.receiverId,

      text: message.text,
      fileUrl: message.fileUrl,

      duration: message.duration, // مهم للصوت

      type: message.type,
      status: message.status,

      createdAt: message.createdAt,

      deletedForEveryone: message.deletedForEveryone,
    );

    await remoteDataSource.sendMessage(model);
  }

  @override
  Future<void> deleteMessageForMe(String messageId) async {
    await remoteDataSource.deleteMessageForMe(messageId);
  }

  @override
  Future<void> deleteMessageForEveryone(String messageId) async {
    await remoteDataSource.deleteMessageForEveryone(messageId);
  }

  @override
  Future<void> markAsSeen(String messageId) async {
    await remoteDataSource.markAsSeen(messageId);
  }

  @override
  Stream<List<Message>> listenMessages(
      String currentUserId,
      String otherUserId,
      ) async* {

    while (true) {

      final messages =
      await remoteDataSource.getMessages(
        currentUserId,
        otherUserId,
      );

      yield messages;

      await Future.delayed(
        const Duration(seconds: 2),
      );
    }
  }

  @override
  Future<void> updateUserStatus(
      String userId,
      UserStatus status,
      ) async {

    await remoteDataSource.updateUserStatus(
      userId,
      status.name,
    );
  }
  @override
  Future<String> uploadFile(String path) {
    return remoteDataSource.uploadFile(path);
  }
}