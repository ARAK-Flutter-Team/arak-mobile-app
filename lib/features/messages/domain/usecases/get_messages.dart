// lib/features/conversations/domain/usecases/get_messages.dart
/*import '../repositories/conversation_repository.dart';
import '../entities/message.dart';

class GetMessagesUseCase {
  final ConversationRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<Message>> call({
    required String userId,
    int page = 1,
    int pageSize = 50,
  }) {
    return repository.getMessages(
      userId: userId,
      page: page,
      pageSize: pageSize,
    );
  }
}*/
import '../repositories/conversation_repository.dart';
import '../entities/message.dart';

class GetMessagesUseCase {
  final ConversationRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<Message>> call({
    required String userId,  // هذا هو ID الشخص التاني في المحادثة
    int page = 1,
    int pageSize = 50,
  }) {
    return repository.getMessages(
      userId: userId,
      page: page,
      pageSize: pageSize,
    );
  }
}