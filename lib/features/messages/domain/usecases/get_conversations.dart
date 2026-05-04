// lib/features/conversations/domain/usecases/get_conversations.dart
import '../repositories/conversation_repository.dart';
import '../entities/conversation.dart';

class GetConversationsUseCase {
  final ConversationRepository repository;

  GetConversationsUseCase(this.repository);

  Future<List<Conversation>> call() {
    return repository.getConversations();
  }
}