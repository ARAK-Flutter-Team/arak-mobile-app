import '../../domain/entities/message.dart';

class ChatState {

  final List<Message> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    required this.messages,
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
  }) {

    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  factory ChatState.initial() {

    return const ChatState(
      messages: [],
      isLoading: false,
      error: null,
    );
  }
}