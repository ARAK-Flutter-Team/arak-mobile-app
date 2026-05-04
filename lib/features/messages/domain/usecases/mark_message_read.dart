// lib/features/conversations/domain/usecases/mark_message_read.dart
import '../repositories/conversation_repository.dart';

class MarkMessageReadUseCase {
  final ConversationRepository repository;

  MarkMessageReadUseCase(this.repository);

  Future<void> call({
    required String userId,
    required int messageId,
  }) {
    return repository.markMessageAsRead(
      userId: userId,
      messageId: messageId,
    );
  }
}