import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/datasource/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../controller/chat_controller.dart';
import '../state/chat_state.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return ChatRemoteDataSource(client);
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remote = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remote);
});

final getMessagesProvider = Provider<GetMessages>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return GetMessages(repo);
});

final sendMessageProvider = Provider<SendMessage>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return SendMessage(repo);
});

final chatControllerProvider =
StateNotifierProvider<ChatController, ChatState>((ref) {
  final getMessages = ref.watch(getMessagesProvider);
  final sendMessage = ref.watch(sendMessageProvider);
  return ChatController(getMessages, sendMessage);
});