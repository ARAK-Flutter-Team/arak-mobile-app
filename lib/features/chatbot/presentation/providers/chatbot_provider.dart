import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/chatbot_remote_datasource.dart';
import '../../domain/entities/chat_message.dart';

class ChatbotNotifier extends StateNotifier<List<ChatMessage>> {
  final ChatbotRemoteDatasource _datasource;

  ChatbotNotifier(this._datasource)
      : super([
          const ChatMessage(
            text: 'أهلاً! أنا مساعد أراك الذكي 🦊 كيف يمكنني مساعدتك؟',
            isUser: false,
          ),
        ]);

  Future<void> sendMessage(String text) async {
    state = [...state, ChatMessage(text: text, isUser: true)];
    state = [...state, const ChatMessage(text: '...', isUser: false)];

    final reply = await _datasource.sendMessage(text);

    final updated = [...state];
    updated[updated.length - 1] = ChatMessage(text: reply, isUser: false);
    state = updated;
  }
}

final chatbotProvider =
    StateNotifierProvider<ChatbotNotifier, List<ChatMessage>>((ref) {
  return ChatbotNotifier(ref.read(chatbotDatasourceProvider));
});
