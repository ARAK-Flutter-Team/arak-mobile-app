import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/entities/conversation.dart';
import '../presentation/providers/chat_provider.dart';

/// حالت المحادثات التي تم فتحها
final conversationReadStateProvider = StateProvider<Set<String>>((ref) => Set<String>());

/// دالة لتحديد أن محادثة معينة تم فتحها
final markConversationAsReadProvider = Provider<(Function(String), Function(String))>((ref) {
  final notifier = ref.read(conversationReadStateProvider.notifier);
  final conversationsProvider = ref.read(conversationsListProvider);

  // دالة لتحديد أن المحادثة تم فتحها
  void markAsOpened(String conversationId) {
    final current = ref.read(conversationReadStateProvider);
    if (!current.contains(conversationId)) {
      notifier.state = {...current, conversationId};
      debugPrint('📖 Marked conversation $conversationId as opened');
    }
  }

  // دالة لإعادة تعيين حالة المحادثة (لما نقرأ كل الرسائل)
  void resetConversation(String conversationId) {
    final current = ref.read(conversationReadStateProvider);
    if (current.contains(conversationId)) {
      final newSet = Set<String>.from(current);
      newSet.remove(conversationId);
      notifier.state = newSet;
      debugPrint('🔄 Reset conversation $conversationId');
    }
  }

  return (markAsOpened, resetConversation);
});

/// هل المحادثة تم فتحها؟
final isConversationOpenedProvider = Provider.family<bool, String>((ref, conversationId) {
  final openedConversations = ref.watch(conversationReadStateProvider);
  return openedConversations.contains(conversationId);
});