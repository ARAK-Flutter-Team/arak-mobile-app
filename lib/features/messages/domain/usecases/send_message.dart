// lib/features/conversations/domain/usecases/send_message.dart
import '../repositories/conversation_repository.dart';
import '../entities/message.dart';

class SendMessageUseCase {
  final ConversationRepository repository;

  SendMessageUseCase(this.repository);

  Future<Message> call({
    required String senderId,
    required String receiverId,
    required String content,
  }) {
    return repository.sendMessage(
      senderId: senderId,
      receiverId: receiverId,
      content: content,
    );
  }
}