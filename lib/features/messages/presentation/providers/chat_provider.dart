/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';

import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/upload_file.dart';

import '../controller/chat_controller.dart';
import '../state/chat_state.dart';

/// HTTP CLIENT
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

/// DATASOURCE
final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return ChatRemoteDataSource(client);
});

/// REPOSITORY
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remote = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remote);
});

/// USECASES
final getMessagesProvider = Provider<GetMessages>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return GetMessages(repo);
});

final sendMessageProvider = Provider<SendMessage>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return SendMessage(repo);
});

final uploadFileProvider = Provider<UploadFile>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return UploadFile(repo);
});

final chatControllerProvider =
StateNotifierProvider<ChatController, ChatState>((ref) {

  final getMessages = ref.watch(getMessagesProvider);
  final sendMessage = ref.watch(sendMessageProvider);
  final uploadFile = ref.watch(uploadFileProvider);

  return ChatController(
    getMessages,
    sendMessage,
    uploadFile,
  );
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';

import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/upload_file.dart';

import '../controller/chat_controller.dart';
import '../state/chat_state.dart';

/// BASE URL
const String baseUrl = "https://your-api.com";

/// HTTP CLIENT
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

/// DATASOURCE
final chatRemoteDataSourceProvider = Provider<ChatRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);

  return ChatRemoteDataSource(
    client: client,
    baseUrl: baseUrl,
  );
});

/// REPOSITORY
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  final remote = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(remote);
});

/// USECASES

final getMessagesProvider = Provider<GetMessages>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return GetMessages(repo);
});

final sendMessageProvider = Provider<SendMessage>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return SendMessage(repo);
});

final uploadFileProvider = Provider<UploadFile>((ref) {
  final repo = ref.watch(chatRepositoryProvider);
  return UploadFile(repo);
});

/// CONTROLLER
final chatControllerProvider =
StateNotifierProvider<ChatController, ChatState>((ref) {
  final getMessages = ref.watch(getMessagesProvider);
  final sendMessage = ref.watch(sendMessageProvider);
  final uploadFile = ref.watch(uploadFileProvider);

  return ChatController(
    getMessages,
    sendMessage,
    uploadFile,
  );
});