import '../../domain/entities/message.dart';

class ChatState {
  final List<Message> messages;
  final bool isLoading;
  final bool isTyping;
  final String? replyingToMessageId;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.isTyping = false,
    this.replyingToMessageId,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    bool? isTyping,
    String? replyingToMessageId,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      replyingToMessageId: replyingToMessageId ?? this.replyingToMessageId,
    );
  }
}