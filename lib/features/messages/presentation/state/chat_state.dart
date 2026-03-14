/*import '../../domain/entities/message.dart';

class ChatState {
  final Map<String, List<Message>> messagesMap; // كل شات له قائمة
  final bool isLoading;
  final bool isTyping;
  final String? replyingToMessageId;

  const ChatState({
    this.messagesMap = const {},
    this.isLoading = false,
    this.isTyping = false,
    this.replyingToMessageId,
  });

  ChatState copyWith({
    Map<String, List<Message>>? messagesMap,
    bool? isLoading,
    bool? isTyping,
    String? replyingToMessageId,
  }) {
    return ChatState(
      messagesMap: messagesMap ?? this.messagesMap,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      replyingToMessageId: replyingToMessageId ?? this.replyingToMessageId,
    );
  }

  // احصل على الرسائل لشات معين
  List<Message> messagesForChat(String chatId) {
    return messagesMap[chatId] ?? [];
  }
}*/
import '../../domain/entities/message.dart';

class ChatState {
  final Map<String, List<Message>> messagesMap;
  final bool isLoading;
  final bool isTyping;
  final String? replyingToMessageId;

  const ChatState({
    this.messagesMap = const {},
    this.isLoading = false,
    this.isTyping = false,
    this.replyingToMessageId,
  });

  ChatState copyWith({
    Map<String, List<Message>>? messagesMap,
    bool? isLoading,
    bool? isTyping,
    String? replyingToMessageId,
  }) {
    return ChatState(
      messagesMap: messagesMap ?? this.messagesMap,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      replyingToMessageId: replyingToMessageId,
    );
  }

  List<Message> messagesForChat(String chatId) {
    return messagesMap[chatId] ?? [];
  }
}