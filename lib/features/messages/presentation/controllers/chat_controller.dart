import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatController extends StateNotifier<AsyncValue<List<Message>>> {

  final ChatRepository repository;

  ChatController(this.repository) : super(const AsyncValue.loading());

  /// ============================
  /// Load Messages
  /// ============================
  Future<void> loadMessages(
      String currentUserId,
      String otherUserId,
      ) async {

    state = const AsyncValue.loading();

    try {

      final messages =
      await repository.getMessages(currentUserId, otherUserId);

      state = AsyncValue.data(messages);

    } catch (e, st) {

      state = AsyncValue.error(e, st);

    }
  }

  /// ============================
  /// Send Message
  /// ============================
  Future<void> sendMessage({
    required String id,
    required String senderId,
    required String receiverId,
    required String text,
  }) async {

    final message = Message(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    await repository.sendMessage(message);

    final currentMessages = state.value ?? [];

    state = AsyncValue.data([
      ...currentMessages,
      message,
    ]);
  }

  /// ============================
  /// Delete For Me
  /// ============================
  Future<void> deleteForMe(String messageId) async {

    await repository.deleteMessageForMe(messageId);

    final currentMessages = state.value ?? [];

    state = AsyncValue.data(
      currentMessages
          .where((m) => m.id != messageId)
          .toList(),
    );
  }

  /// ============================
  /// Delete For Everyone
  /// ============================
  Future<void> deleteForEveryone(String messageId) async {

    await repository.deleteMessageForEveryone(messageId);

    final currentMessages = state.value ?? [];

    final updated = currentMessages.map((m) {

      if (m.id == messageId) {

        return Message(
          id: m.id,
          senderId: m.senderId,
          receiverId: m.receiverId,
          text: "This message was deleted",
          createdAt: m.createdAt,
          deletedForEveryone: true,
        );
      }

      return m;

    }).toList();

    state = AsyncValue.data(updated);
  }
}