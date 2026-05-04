/*import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/mark_message_read.dart';
import '../../domain/usecases/mark_all_messages_read.dart';
import '../state/chat_state.dart';

class ChatController extends StateNotifier<ChatState> {
  final GetMessagesUseCase getMessages;
  final SendMessageUseCase sendMessage;
  final MarkMessageReadUseCase markMessageRead;
  final MarkAllMessagesReadUseCase markAllMessagesRead;

  ChatController({
    required this.getMessages,
    required this.sendMessage,
    required this.markMessageRead,
    required this.markAllMessagesRead,
  }) : super(const ChatState());

  Future<void> loadMessages({
    required String currentUserId,
    required String otherUserId,
    int page = 1,
    int pageSize = 50,
    bool showLoading = true,
  }) async {
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('🔄 [LOAD MESSAGES] Starting...');
    debugPrint('👤 Current User ID: $currentUserId');
    debugPrint('👤 Other User ID: $otherUserId');

    if (currentUserId == otherUserId) {
      debugPrint('❌ Cannot load messages with self');
      if (showLoading) {
        state = state.copyWith(isLoading: false);
      }
      return;
    }

    if (showLoading) {
      state = state.copyWith(isLoading: true);
    }

    final chatId = _chatId(currentUserId, otherUserId);

    try {
      final messages = await getMessages(
        userId: otherUserId,
        page: page,
        pageSize: pageSize,
      );

      final filteredMessages = messages.where((msg) {
        return (msg.senderId == currentUserId && msg.receiverId == otherUserId) ||
            (msg.senderId == otherUserId && msg.receiverId == currentUserId);
      }).toList();

      final sortedMessages = List.of(filteredMessages)
        ..sort((a, b) => a.sentAt.compareTo(b.sentAt));

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          chatId: sortedMessages,
        },
        isLoading: false,
      );

      debugPrint('✅ State updated: ${sortedMessages.length} messages in chat $chatId');

      await _markMessagesAsRead(currentUserId, sortedMessages);
    } catch (e) {
      debugPrint('❌ Error loading messages: $e');
      if (showLoading) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> _markMessagesAsRead(String currentUserId, List<Message> messages) async {
    final unreadMessages = messages.where((msg) =>
    !msg.isRead && msg.receiverId == currentUserId
    ).toList();

    if (unreadMessages.isEmpty) return;

    debugPrint('📖 Marking ${unreadMessages.length} messages as read');

    for (var msg in unreadMessages) {
      try {
        await markMessageRead(
          userId: currentUserId,
          messageId: msg.id,
        );
        _updateMessageReadStatus(currentUserId, msg.id, true);
      } catch (e) {
        debugPrint('❌ Error marking message ${msg.id} as read: $e');
      }
    }
  }

  Future<Message?> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('📤 [SEND MESSAGE] Starting...');
    debugPrint('👤 Sender ID: $senderId');
    debugPrint('👤 Receiver ID: $receiverId');

    if (senderId == receiverId || text.trim().isEmpty) {
      return null;
    }

    final chatId = _chatId(senderId, receiverId);

    // ✅ إنشاء رسالة مؤقتة
    final tempMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch,
      senderId: senderId,
      senderName: '',
      receiverId: receiverId,
      receiverName: '',
      content: text,
      sentAt: DateTime.now(),
      isRead: false,
    );

    // ✅ إضافة الرسالة المؤقتة للواجهة مباشرة (بدون إعادة تحميل)
    final currentMessages = List<Message>.from(state.messagesMap[chatId] ?? []);

    state = state.copyWith(
      messagesMap: {
        ...state.messagesMap,
        chatId: [...currentMessages, tempMessage],
      },
    );

    debugPrint('✅ Temp message added to UI');

    try {
      final sentMessage = await sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        content: text,
      );

      // ✅ استبدال الرسالة المؤقتة بالرسالة الحقيقية
      final updatedMessages = state.messagesMap[chatId]!.map((msg) {
        if (msg.id == tempMessage.id) {
          return sentMessage;
        }
        return msg;
      }).toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          chatId: updatedMessages,
        },
      );

      debugPrint('✅ Real message added to UI (no reload needed)');
      return sentMessage;
    } catch (e) {
      // ✅ لو فشل الإرسال، شيل الرسالة المؤقتة
      final updatedMessages = state.messagesMap[chatId]!
          .where((msg) => msg.id != tempMessage.id)
          .toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          chatId: updatedMessages,
        },
      );

      debugPrint('❌ Message failed, temp message removed');
      return null;
    }
  }

  Future<void> refreshMessages({
    required String currentUserId,
    required String otherUserId,
  }) async {
    debugPrint('🔄 [REFRESH] Pull to refresh triggered');
    await loadMessages(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
      showLoading: false,
    );
  }

  void _updateMessageReadStatus(String userId, int messageId, bool isRead) {
    final newMessagesMap = Map<String, List<Message>>.from(state.messagesMap);

    for (final entry in newMessagesMap.entries) {
      final updatedMessages = entry.value.map((msg) {
        if (msg.id == messageId && msg.receiverId == userId) {
          return Message(
            id: msg.id,
            senderId: msg.senderId,
            senderName: msg.senderName,
            receiverId: msg.receiverId,
            receiverName: msg.receiverName,
            content: msg.content,
            sentAt: msg.sentAt,
            isRead: isRead,
          );
        }
        return msg;
      }).toList();

      newMessagesMap[entry.key] = updatedMessages;
    }

    state = state.copyWith(messagesMap: newMessagesMap);
  }

  void setTyping(bool isTyping) {
    state = state.copyWith(isTyping: isTyping);
  }

  void clearMessages(String userA, String userB) {
    final chatId = _chatId(userA, userB);
    final newMessagesMap = Map<String, List<Message>>.from(state.messagesMap);
    newMessagesMap.remove(chatId);
    state = state.copyWith(messagesMap: newMessagesMap);
  }

  void clearAllMessages() {
    state = state.copyWith(messagesMap: {});
  }

  String _chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }
}*/
// lib/features/conversations/presentation/controller/chat_controller.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/mark_message_read.dart';
import '../../domain/usecases/mark_all_messages_read.dart';
import '../state/chat_state.dart';

class ChatController extends StateNotifier<ChatState> {
  final GetMessagesUseCase getMessages;
  final SendMessageUseCase sendMessage;
  final MarkMessageReadUseCase markMessageRead;
  final MarkAllMessagesReadUseCase markAllMessagesRead;

  ChatController({
    required this.getMessages,
    required this.sendMessage,
    required this.markMessageRead,
    required this.markAllMessagesRead,
  }) : super(const ChatState());

  Future<void> loadMessages({
    required String currentUserId,
    required String otherUserId,
    int page = 1,
    int pageSize = 50,
    bool showLoading = true,
  }) async {
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('🔄 [LOAD MESSAGES] Starting...');
    debugPrint('👤 Current User ID: $currentUserId');
    debugPrint('👤 Other User ID: $otherUserId');

    if (currentUserId == otherUserId) {
      debugPrint('❌ Cannot load messages with self');
      if (showLoading) {
        state = state.copyWith(isLoading: false);
      }
      return;
    }

    if (showLoading) {
      state = state.copyWith(isLoading: true);
    }

    final chatId = _chatId(currentUserId, otherUserId);

    try {
      final messages = await getMessages(
        userId: otherUserId,
        page: page,
        pageSize: pageSize,
      );

      final filteredMessages = messages.where((msg) {
        return (msg.senderId == currentUserId && msg.receiverId == otherUserId) ||
            (msg.senderId == otherUserId && msg.receiverId == currentUserId);
      }).toList();

      // ✅ ✅ ✅ التعديل هنا ✅ ✅ ✅
      final sortedMessages = List.of(filteredMessages)
        ..sort((a, b) => b.sentAt.compareTo(a.sentAt)); // تنازلي (جديد لقديم)

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          chatId: sortedMessages,
        },
        isLoading: false,
      );

      debugPrint('✅ State updated: ${sortedMessages.length} messages in chat $chatId');

      await _markMessagesAsRead(currentUserId, sortedMessages);
    } catch (e) {
      debugPrint('❌ Error loading messages: $e');
      if (showLoading) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> _markMessagesAsRead(String currentUserId, List<Message> messages) async {
    final unreadMessages = messages.where((msg) =>
    !msg.isRead && msg.receiverId == currentUserId
    ).toList();

    if (unreadMessages.isEmpty) return;

    debugPrint('📖 Marking ${unreadMessages.length} messages as read');

    for (var msg in unreadMessages) {
      try {
        await markMessageRead(
          userId: currentUserId,
          messageId: msg.id,
        );
        _updateMessageReadStatus(currentUserId, msg.id, true);
      } catch (e) {
        debugPrint('❌ Error marking message ${msg.id} as read: $e');
      }
    }
  }

  Future<Message?> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    debugPrint('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    debugPrint('📤 [SEND MESSAGE] Starting...');
    debugPrint('👤 Sender ID: $senderId');
    debugPrint('👤 Receiver ID: $receiverId');

    if (senderId == receiverId || text.trim().isEmpty) {
      return null;
    }

    final chatId = _chatId(senderId, receiverId);

    final tempMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch,
      senderId: senderId,
      senderName: '',
      receiverId: receiverId,
      receiverName: '',
      content: text,
      sentAt: DateTime.now(),
      isRead: false,
    );

    final currentMessages = List<Message>.from(state.messagesMap[chatId] ?? []);

    // ✅ ✅ ✅ التعديل هنا ✅ ✅ ✅
    // بنضيف الرسالة الجديدة في أول الليست (Index 0) عشان الليست مرتبة تنازلياً
    state = state.copyWith(
      messagesMap: {
        ...state.messagesMap,
        chatId: [tempMessage, ...currentMessages],
      },
    );

    debugPrint('✅ Temp message added to UI (at index 0)');

    try {
      final sentMessage = await sendMessage(
        senderId: senderId,
        receiverId: receiverId,
        content: text,
      );

      // استبدال الرسالة المؤقتة بالرسالة الحقيقية
      final updatedMessages = state.messagesMap[chatId]!.map((msg) {
        if (msg.id == tempMessage.id) {
          return sentMessage;
        }
        return msg;
      }).toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          chatId: updatedMessages,
        },
      );

      debugPrint('✅ Real message added to UI');
      return sentMessage;
    } catch (e) {
      // لو فشل الإرسال نشيل الرسالة المؤقتة
      final updatedMessages = state.messagesMap[chatId]!
          .where((msg) => msg.id != tempMessage.id)
          .toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          chatId: updatedMessages,
        },
      );

      debugPrint('❌ Message failed, temp message removed');
      return null;
    }
  }

  Future<void> refreshMessages({
    required String currentUserId,
    required String otherUserId,
  }) async {
    debugPrint('🔄 [REFRESH] Pull to refresh triggered');
    await loadMessages(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
      showLoading: false,
    );
  }

  void _updateMessageReadStatus(String userId, int messageId, bool isRead) {
    final newMessagesMap = Map<String, List<Message>>.from(state.messagesMap);

    for (final entry in newMessagesMap.entries) {
      final updatedMessages = entry.value.map((msg) {
        if (msg.id == messageId && msg.receiverId == userId) {
          return Message(
            id: msg.id,
            senderId: msg.senderId,
            senderName: msg.senderName,
            receiverId: msg.receiverId,
            receiverName: msg.receiverName,
            content: msg.content,
            sentAt: msg.sentAt,
            isRead: isRead,
          );
        }
        return msg;
      }).toList();

      newMessagesMap[entry.key] = updatedMessages;
    }

    state = state.copyWith(messagesMap: newMessagesMap);
  }

  void setTyping(bool isTyping) {
    state = state.copyWith(isTyping: isTyping);
  }

  void clearMessages(String userA, String userB) {
    final chatId = _chatId(userA, userB);
    final newMessagesMap = Map<String, List<Message>>.from(state.messagesMap);
    newMessagesMap.remove(chatId);
    state = state.copyWith(messagesMap: newMessagesMap);
    debugPrint('🗑️ Cleared messages for chat: $chatId');
  }

  void clearAllMessages() {
    state = state.copyWith(messagesMap: {});
    debugPrint('🗑️ Cleared all messages');
  }

  String _chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }
}