import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class GetMessages {
  final ChatRepository repository;
  GetMessages(this.repository);

  Future<List<Message>> call(String userId, String otherUserId) {
    return repository.getMessages(userId, otherUserId);
  }
}