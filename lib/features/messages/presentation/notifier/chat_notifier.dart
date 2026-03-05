import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../state/chat_state.dart';

class ChatNotifier extends StateNotifier<ChatState> {

  final ChatRepository repository;

  ChatNotifier(this.repository) : super(ChatState.initial());

  Future<void> loadMessages(
      String currentUserId,
      String otherUserId,
      ) async {

    state = state.copyWith(isLoading: true);

    try {

      final messages =
      await repository.getMessages(currentUserId, otherUserId);

      state = state.copyWith(
        messages: messages,
        isLoading: false,
      );

    } catch (e) {

      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {

    final message = Message(
      id: const Uuid().v4(),
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    state = state.copyWith(
      messages: [...state.messages, message],
    );

    await repository.sendMessage(message);
  }

  Future<void> deleteForEveryone(String messageId) async {

    await repository.deleteMessageForEveryone(messageId);

    final updated = state.messages.map((m) {

      if (m.id == messageId) {

        return m.copyWith(
          text: "This message was deleted",
          deletedForEveryone: true,
        );
      }

      return m;

    }).toList();

    state = state.copyWith(messages: updated);
  }

  Future<void> deleteForMe(String messageId) async {

    await repository.deleteMessageForMe(messageId);

    final updated =
    state.messages.where((m) => m.id != messageId).toList();

    state = state.copyWith(messages: updated);
  }
}