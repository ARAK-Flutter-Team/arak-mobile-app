// lib/features/conversations/providers/conversation_providers.dart
/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../data/datasource/chat_remote_datasource.dart';
import '../data/repositories/chat_repository_impl.dart';
import '../domain/repositories/conversation_repository.dart';
import '../domain/usecases/get_conversations.dart';
import '../domain/usecases/get_messages.dart';
import '../domain/usecases/send_message.dart';
import '../domain/usecases/mark_message_read.dart';
import '../domain/usecases/mark_all_messages_read.dart';
import '../domain/entities/conversation.dart';
import '../presentation/controller/chat_controller.dart';
import '../presentation/state/chat_state.dart';

// ==================== Data Sources ====================
final conversationRemoteDataSourceProvider = Provider<ConversationRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ConversationRemoteDataSource(dio);
});

// ==================== Repositories ====================
final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  final remoteDataSource = ref.watch(conversationRemoteDataSourceProvider);
  return ConversationRepositoryImpl(remoteDataSource);
});

// ==================== UseCases ====================
final getConversationsUseCaseProvider = Provider<GetConversationsUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return GetConversationsUseCase(repository);
});

final getMessagesUseCaseProvider = Provider<GetMessagesUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return GetMessagesUseCase(repository);
});

final sendMessageUseCaseProvider = Provider<SendMessageUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return SendMessageUseCase(repository);
});

final markMessageReadUseCaseProvider = Provider<MarkMessageReadUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return MarkMessageReadUseCase(repository);
});

final markAllMessagesReadUseCaseProvider = Provider<MarkAllMessagesReadUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return MarkAllMessagesReadUseCase(repository);
});

// ==================== Async Providers ====================
final conversationsListProvider = FutureProvider<List<Conversation>>((ref) async {
  final getConversations = ref.watch(getConversationsUseCaseProvider);
  return await getConversations();
});

// ==================== Chat Controller ====================
final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  final getMessages = ref.watch(getMessagesUseCaseProvider);
  final sendMessage = ref.watch(sendMessageUseCaseProvider);
  final markRead = ref.watch(markMessageReadUseCaseProvider);
  final markAllRead = ref.watch(markAllMessagesReadUseCaseProvider);

  return ChatController(
    getMessages: getMessages,
    sendMessage: sendMessage,
    markMessageRead: markRead,
    markAllMessagesRead: markAllRead,
  );
});

// ==================== Helpers ====================
final totalUnreadCountProvider = Provider<int>((ref) {
  final conversationsAsync = ref.watch(conversationsListProvider);
  return conversationsAsync.when(
    data: (conversations) => conversations.fold(0, (sum, conv) => sum + conv.unreadCount),
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final hasUnreadMessagesProvider = Provider<bool>((ref) {
  return ref.watch(totalUnreadCountProvider) > 0;
});*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_provider.dart';
import '../data/datasource/chat_remote_datasource.dart';
import '../data/datasource/user_remote_datasource.dart';
import '../data/repositories/chat_repository_impl.dart';
import '../data/repositories/user_repository_impl.dart'; // Import جديد
import '../domain/repositories/conversation_repository.dart';
import '../domain/repositories/user_repository.dart'; // Import جديد
import '../domain/usecases/get_conversations.dart';
import '../domain/usecases/get_messages.dart';
import '../domain/usecases/send_message.dart';
import '../domain/usecases/mark_message_read.dart';
import '../domain/usecases/mark_all_messages_read.dart';
import '../domain/usecases/search_users.dart'; // Import جديد
import '../domain/usecases/get_all_users.dart'; // Import جديد
import '../domain/entities/conversation.dart';
import '../domain/entities/message.dart';
import '../data/models/user_model.dart'; // Import جديد
import '../presentation/controller/chat_controller.dart';
import '../presentation/state/chat_state.dart';

// ==================== Data Sources ====================
final conversationRemoteDataSourceProvider = Provider<ConversationRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ConversationRemoteDataSource(dio);
});

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRemoteDataSource(dio);
});

// ==================== Repositories ====================
final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  final remoteDataSource = ref.watch(conversationRemoteDataSourceProvider);
  return ConversationRepositoryImpl(remoteDataSource);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(remoteDataSource);
});

// ==================== UseCases ====================
final getConversationsUseCaseProvider = Provider<GetConversationsUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return GetConversationsUseCase(repository);
});

final getMessagesUseCaseProvider = Provider<GetMessagesUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return GetMessagesUseCase(repository);
});

final sendMessageUseCaseProvider = Provider<SendMessageUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return SendMessageUseCase(repository);
});

final markMessageReadUseCaseProvider = Provider<MarkMessageReadUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return MarkMessageReadUseCase(repository);
});

final markAllMessagesReadUseCaseProvider = Provider<MarkAllMessagesReadUseCase>((ref) {
  final repository = ref.watch(conversationRepositoryProvider);
  return MarkAllMessagesReadUseCase(repository);
});

// User UseCases
final searchUsersUseCaseProvider = Provider<SearchUsersUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return SearchUsersUseCase(repository);
});

final getAllUsersUseCaseProvider = Provider<GetAllUsersUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetAllUsersUseCase(repository);
});

// ==================== Async Providers ====================
final conversationsListProvider = FutureProvider<List<Conversation>>((ref) async {
  final getConversations = ref.watch(getConversationsUseCaseProvider);
  return await getConversations();
});

// ==================== Search Providers ====================
final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider.family<List<UserModel>, String>((ref, query) async {
  if (query.isEmpty || query.length < 1) {
    return [];
  }
  final searchUsers = ref.watch(searchUsersUseCaseProvider);
  return await searchUsers(query);
});

final isSearchingProvider = StateProvider<bool>((ref) => false);

// ==================== Chat Controller ====================
final chatControllerProvider = StateNotifierProvider<ChatController, ChatState>((ref) {
  final getMessages = ref.watch(getMessagesUseCaseProvider);
  final sendMessage = ref.watch(sendMessageUseCaseProvider);
  final markRead = ref.watch(markMessageReadUseCaseProvider);
  final markAllRead = ref.watch(markAllMessagesReadUseCaseProvider);

  return ChatController(
    getMessages: getMessages,
    sendMessage: sendMessage,
    markMessageRead: markRead,
    markAllMessagesRead: markAllRead,
  );
});

// ==================== Helpers ====================
final totalUnreadCountProvider = Provider<int>((ref) {
  final conversationsAsync = ref.watch(conversationsListProvider);
  return conversationsAsync.when(
    data: (conversations) => conversations.fold(0, (sum, conv) => sum + conv.unreadCount),
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final hasUnreadMessagesProvider = Provider<bool>((ref) {
  return ref.watch(totalUnreadCountProvider) > 0;
});