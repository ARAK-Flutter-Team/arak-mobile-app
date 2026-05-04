// lib/features/conversations/providers/conversation_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/chat_remote_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../../domain/usecases/get_conversations.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/mark_all_messages_read.dart';
import '../../domain/usecases/mark_message_read.dart';
import '../../domain/usecases/send_message.dart';
import '../controller/chat_controller.dart';
import '../state/chat_state.dart';

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

// ==================== Async Providers للـ UI ====================
final conversationsListProvider = FutureProvider<List<Conversation>>((ref) async {
  final getConversations = ref.watch(getConversationsUseCaseProvider);
  return await getConversations();
});

final messagesProvider = FutureProvider.family<List<Message>, String>((ref, userId) async {
  final getMessages = ref.watch(getMessagesUseCaseProvider);
  return await getMessages(userId: userId, page: 1, pageSize: 50);
});

// ==================== Helper Providers (مفيدة للـ UI) ====================

/// عدد الرسائل غير المقروءة في كل المحادثات
final totalUnreadCountProvider = Provider<int>((ref) {
  final conversationsAsync = ref.watch(conversationsListProvider);
  return conversationsAsync.when(
    data: (conversations) => conversations.fold(0, (sum, conv) => sum + conv.unreadCount),
    loading: () => 0,
    error: (_, __) => 0,
  );
});

/// هل يوجد رسائل غير مقروءة؟
final hasUnreadMessagesProvider = Provider<bool>((ref) {
  return ref.watch(totalUnreadCountProvider) > 0;
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
