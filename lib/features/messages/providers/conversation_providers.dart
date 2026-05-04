import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import 'package:arak_app/core/entities/user.dart';
import 'package:arak_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:arak_app/features/search/presentation/providers/search_providers.dart' as search;
import 'package:arak_app/features/search-page/domain/entities/student.dart';
import 'package:arak_app/features/messages/data/datasource/chat_remote_datasource.dart';
import 'package:arak_app/features/messages/data/datasource/user_remote_datasource.dart';
import 'package:arak_app/features/messages/data/repositories/chat_repository_impl.dart';
import 'package:arak_app/features/messages/data/repositories/user_repository_impl.dart';
import 'package:arak_app/features/messages/domain/repositories/conversation_repository.dart';
import 'package:arak_app/features/messages/domain/repositories/user_repository.dart';
import 'package:arak_app/features/messages/domain/usecases/get_conversations.dart';
import 'package:arak_app/features/messages/domain/usecases/get_messages.dart';
import 'package:arak_app/features/messages/domain/usecases/send_message.dart';
import 'package:arak_app/features/messages/domain/usecases/mark_message_read.dart';
import 'package:arak_app/features/messages/domain/usecases/mark_all_messages_read.dart';
import 'package:arak_app/features/messages/domain/usecases/search_users.dart';
import 'package:arak_app/features/messages/domain/usecases/get_all_users.dart';
import 'package:arak_app/features/messages/domain/entities/conversation.dart';
import 'package:arak_app/features/messages/data/models/user_model.dart';
import 'package:arak_app/features/messages/presentation/controller/chat_controller.dart';
import 'package:arak_app/features/messages/presentation/state/chat_state.dart';

// ==================== Data Sources ====================
final conversationRemoteDataSourceProvider =
    Provider<ConversationRemoteDataSource>((ref) {
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
final getConversationsUseCaseProvider =
    Provider<GetConversationsUseCase>((ref) {
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

final markAllMessagesReadUseCaseProvider =
    Provider<MarkAllMessagesReadUseCase>((ref) {
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
final conversationsListProvider =
    FutureProvider<List<Conversation>>((ref) async {
  final getConversations = ref.watch(getConversationsUseCaseProvider);
  return await getConversations();
});

// ==================== Search Providers ====================
final searchQueryProvider = StateProvider<String>((ref) => '');

/// 🔍 البحث: بيجمع بين المحادثات الموجودة والبحث عن مستخدمين جدد
final searchResultsProvider = FutureProvider.family<List<dynamic>, String>((ref, query) async {
  if (query.isEmpty) return [];

  // 1. تصفية المحادثات الموجودة محلياً (بالاسم)
  final conversationsAsync = ref.watch(conversationsListProvider);
  final List<Conversation> localResults = conversationsAsync.when(
    data: (conversations) => conversations
        .where((conv) => conv.otherPartyName.toLowerCase().contains(query.toLowerCase()))
        .toList(),
    loading: () => [],
    error: (_, __) => [],
  );

  // نبدأ بنتائج المحادثات المحلية
  final List<dynamic> finalResults = [...localResults];

  // 2. البحث عن مستخدمين جدد عبر الـ API (بالبريد الإلكتروني فقط)
  if (query.contains('@')) {
    try {
      final searchUsers = ref.read(searchUsersUseCaseProvider);
      final remoteResults = await searchUsers(query);
      for (final user in remoteResults) {
        final exists = finalResults.any((item) {
          if (item is Conversation) return item.otherPartyId == user.id;
          if (item is UserModel) return item.id == user.id;
          return false;
        });
        if (!exists) finalResults.add(user);
      }
    } catch (e) {
      print('Remote search error: $e');
    }
  }

  // 3. لو المستخدم معلم، بنضيف الطلاب اللي عندهم UUID حقيقي
  final currentUser = ref.read(authProvider).user;
  if (currentUser?.role == UserRole.teacher) {
    final studentsAsync = ref.watch(search.studentsProvider);
    final students = studentsAsync.value ?? [];

    for (final student in students) {
      // تجاهل الطلاب بدون UUID حقيقي
      if (student.id.isEmpty || student.id == "0") continue;
      // فلتر بالاسم
      if (!student.name.toLowerCase().contains(query.toLowerCase())) continue;

      final alreadyInResults = finalResults.any((item) {
        if (item is Conversation) return item.otherPartyId == student.id;
        if (item is UserModel) return item.id == student.id;
        return false;
      });

      if (!alreadyInResults) {
        finalResults.add(UserModel(
          id: student.id,   // ✅ UUID حقيقي
          name: student.name,
          email: 'Parent',
          isActive: true,
          role: 'parent',
        ));
      }
    }
  }

  return finalResults;
});


final isSearchingProvider = StateProvider<bool>((ref) => false);

// ==================== Chat Controller ====================
final chatControllerProvider =
    StateNotifierProvider<ChatController, ChatState>((ref) {
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
    data: (conversations) =>
        conversations.fold(0, (sum, conv) => sum + conv.unreadCount),
    loading: () => 0,
    error: (_, __) => 0,
  );
});

final hasUnreadMessagesProvider = Provider<bool>((ref) {
  return ref.watch(totalUnreadCountProvider) > 0;
});
