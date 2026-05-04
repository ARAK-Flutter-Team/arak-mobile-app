// lib/features/conversations/domain/usecases/mark_all_messages_read.dart
import '../repositories/conversation_repository.dart';

class MarkAllMessagesReadUseCase {
  final ConversationRepository repository;

  MarkAllMessagesReadUseCase(this.repository);

  Future<void> call({
    required String userId,
  }) {
    return repository.markAllMessagesAsRead(userId: userId);
  }
}
