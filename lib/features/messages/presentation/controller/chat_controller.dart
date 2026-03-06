/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../state/chat_state.dart';

class ChatController extends StateNotifier<ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessage;

  ChatController(this.getMessages, this.sendMessage) : super(const ChatState());

  /// LOAD MESSAGES
  Future<void> loadMessages(String currentUserId, String otherUserId) async {
    state = state.copyWith(isLoading: true);
    try {
      final messages = await getMessages(currentUserId, otherUserId);
      state = state.copyWith(messages: messages, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// SEND TEXT MESSAGE
  Future<void> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      fileUrl: null,
      type: MessageType.text,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    /// optimistic update
    state = state.copyWith(messages: [...state.messages, message]);

    await sendMessage(message);
  }

  /// DELETE FOR ME
  void deleteForMe(String messageId) {
    final updated = state.messages.where((m) => m.id != messageId).toList();
    state = state.copyWith(messages: updated);
  }

  /// DELETE FOR EVERYONE
  void deleteForEveryone(String messageId) {
    final updated = state.messages.where((m) => m.id != messageId).toList();
    state = state.copyWith(messages: updated);
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../state/chat_state.dart';

class ChatController extends StateNotifier<ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessage;

  ChatController(this.getMessages, this.sendMessage) : super(const ChatState());

  /// LOAD MESSAGES
  Future<void> loadMessages(String currentUserId, String otherUserId) async {
    state = state.copyWith(isLoading: true);
    try {
      final messages = await getMessages(currentUserId, otherUserId);
      state = state.copyWith(messages: messages, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// SEND TEXT MESSAGE
  Future<void> sendTextMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      fileUrl: null,
      type: MessageType.text,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    // optimistic update
    state = state.copyWith(messages: [...state.messages, message]);

    await sendMessage(message);
  }

  /// SEND IMAGE MESSAGE
  Future<void> sendImageMessage({
    required String senderId,
    required String receiverId,
    required String filePath,
  }) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      text: null,
      fileUrl: filePath,
      type: MessageType.image,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    state = state.copyWith(messages: [...state.messages, message]);
    await sendMessage(message);
  }

  /// SEND FILE MESSAGE
  Future<void> sendFileMessage({
    required String senderId,
    required String receiverId,
    required String filePath,
  }) async {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      text: null,
      fileUrl: filePath,
      type: MessageType.file,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    state = state.copyWith(messages: [...state.messages, message]);
    await sendMessage(message);
  }

  /// SEND VOICE MESSAGE
  Future<void> sendVoiceMessage({
    required String senderId,
    required String receiverId,
    required String filePath,
    required int duration,
  }) async {

    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      receiverId: receiverId,
      text: null,
      fileUrl: filePath,
      duration: duration,
      type: MessageType.voice,
      status: MessageStatus.sending,
      createdAt: DateTime.now(),
      deletedForEveryone: false,
    );

    state = state.copyWith(messages: [...state.messages, message]);

    await sendMessage(message);
  }

  /// DELETE FOR ME
  void deleteForMe(String messageId) {
    final updated = state.messages.where((m) => m.id != messageId).toList();
    state = state.copyWith(messages: updated);
  }

  /// DELETE FOR EVERYONE
  void deleteForEveryone(String messageId) {
    final updated = state.messages.where((m) => m.id != messageId).toList();
    state = state.copyWith(messages: updated);
  }
}