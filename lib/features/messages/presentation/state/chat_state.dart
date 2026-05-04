// lib/features/conversations/presentation/state/chat_state.dart
import '../../domain/entities/message.dart';

class ChatState {
  final Map<String, List<Message>> messagesMap;
  final bool isLoading;
  final bool isTyping;

  const ChatState({
    this.messagesMap = const {},
    this.isLoading = false,
    this.isTyping = false,
  });

  ChatState copyWith({
    Map<String, List<Message>>? messagesMap,
    bool? isLoading,
    bool? isTyping,
  }) {
    return ChatState(
      messagesMap: messagesMap ?? this.messagesMap,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  String toString() {
    return 'ChatState(messagesMap: ${messagesMap.length} chats, isLoading: $isLoading, isTyping: $isTyping)';
  }
}