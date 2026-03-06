import '../repositories/chat_repository.dart';

class UploadFile {
  final ChatRepository repository;

  UploadFile(this.repository);

  Future<String> call(String path) {
    return repository.uploadFile(path);
  }
}