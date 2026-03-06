import '../repositories/chat_repository.dart';

class DeleteForEveryone {
  final ChatRepository repository;
  DeleteForEveryone(this.repository);

  Future<void> call(String messageId) {
    return repository.deleteMessageForEveryone(messageId);
  }
}