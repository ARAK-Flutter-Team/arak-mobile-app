import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/upload_file.dart';
import '../../data/local/chat_local_datasource.dart';
import '../../data/models/message_model.dart';

import '../state/chat_state.dart';

class ChatController extends StateNotifier<ChatState> {
  final GetMessages getMessages;
  final SendMessage sendMessage;
  final UploadFile uploadFile;
  final ChatLocalDatasource localDatasource;

  ChatController(
      this.getMessages,
      this.sendMessage,
      this.uploadFile,
      this.localDatasource,
      ) : super(const ChatState());


  /// إنشاء chatId ثابت
  String chatId(String userA, String userB) {
    final ids = [userA, userB]..sort();
    return ids.join('_');
  }

  /// تحميل الرسائل
  Future<void> loadMessages(
      String currentUserId,
      String otherUserId,
      ) async {
    state = state.copyWith(isLoading: true);
    final id = chatId(currentUserId, otherUserId);

    final localMessages = await localDatasource.loadMessages(id);

    if (localMessages.isNotEmpty) {

      final messages = localMessages
          .map((e) => MessageModel.fromJson(e))
          .toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          id: messages,
        },
      );
    }

    try {
      final messages = await getMessages(currentUserId, otherUserId);

      final filteredMessages = messages.where((msg) {
        return (msg.senderId == currentUserId &&
            msg.receiverId == otherUserId) ||
            (msg.senderId == otherUserId &&
                msg.receiverId == currentUserId);
      }).toList();

      final id = chatId(currentUserId, otherUserId);

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          id: filteredMessages,
        },
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  /// إرسال رسالة عامة
  Future<void> _sendMessageToChat(
      String senderId,
      String receiverId,
      Message message,
      ) async {
    final id = chatId(senderId, receiverId);

    final currentMessages =
    List<Message>.from(state.messagesMap[id] ?? []);

    /// إضافة الرسالة فوراً
    state = state.copyWith(
      messagesMap: {
        ...state.messagesMap,
        id: [message, ...currentMessages],
      },
    );
    final newMessages = [message, ...currentMessages];

    await localDatasource.saveMessages(
      id,
      newMessages
          .map((e) => MessageModel(
        id: e.id,
        senderId: e.senderId,
        receiverId: e.receiverId,
        text: e.text,
        fileUrl: e.fileUrl,
        duration: e.duration,
        type: e.type,
        status: e.status,
        createdAt: e.createdAt,
        deletedForEveryone: e.deletedForEveryone,
        replyToMessageId: e.replyToMessageId,
      ).toJson())
          .toList(),
    );


    try {
      await sendMessage(message);

      final updatedMessages =
      List<Message>.from(state.messagesMap[id] ?? []).map((m) {
        if (m.id == message.id) {
          return m.copyWith(status: MessageStatus.sent);
        }
        return m;
      }).toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          id: updatedMessages,
        },
      );
    } catch (e) {
      final updatedMessages =
      List<Message>.from(state.messagesMap[id] ?? []).map((m) {
        if (m.id == message.id) {
          return m.copyWith(status: MessageStatus.failed);
        }
        return m;
      }).toList();

      state = state.copyWith(
        messagesMap: {
          ...state.messagesMap,
          id: updatedMessages,
        },
      );
    }
  }

  /// إرسال نص
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

    await _sendMessageToChat(senderId, receiverId, message);
  }

  /// إرسال صورة
  Future<void> sendImageMessage({
    required String senderId,
    required String receiverId,
    required String filePath,
  }) async {

    try {
//final uploadedUrl = await uploadFile(filePath);
      final uploadedUrl = filePath;

      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: senderId,
        receiverId: receiverId,
        text: null,
        fileUrl: uploadedUrl,
        type: MessageType.image,
        status: MessageStatus.sending,
        createdAt: DateTime.now(),
        deletedForEveryone: false,
      );

      await _sendMessageToChat(senderId, receiverId, message);

    } catch (e) {
      debugPrint("IMAGE SEND ERROR: $e");
    }
  }

  /// إرسال ملف
  Future<void> sendFileMessage({
    required String senderId,
    required String receiverId,
    required String filePath,
  }) async {

    try {
//final uploadedUrl = await uploadFile(filePath);
      final uploadedUrl = filePath;

      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: senderId,
        receiverId: receiverId,
        text: null,
        fileUrl: uploadedUrl,
        type: MessageType.file,
        status: MessageStatus.sending,
        createdAt: DateTime.now(),
        deletedForEveryone: false,
      );

      await _sendMessageToChat(senderId, receiverId, message);

    } catch (e) {
      debugPrint("FILE SEND ERROR: $e");
    }
  }

  /// إرسال صوت
  Future<void> sendVoiceMessage({
    required String senderId,
    required String receiverId,
    required String filePath,
    required int duration,
  }) async {

    try {

      //final uploadedUrl = await uploadFile(filePath);
      final uploadedUrl = filePath;
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        senderId: senderId,
        receiverId: receiverId,
        text: null,
        fileUrl: uploadedUrl,
        duration: duration,
        type: MessageType.voice,
        status: MessageStatus.sending,
        createdAt: DateTime.now(),
        deletedForEveryone: false,
      );

      await _sendMessageToChat(senderId, receiverId, message);

    } catch (e) {
      debugPrint("VOICE SEND ERROR: $e");
    }
  }

  /// حذف لي فقط
  void deleteForMe(
      String senderId,
      String receiverId,
      String messageId,
      ) {
    final id = chatId(senderId, receiverId);

    final updated =
    List<Message>.from(state.messagesMap[id] ?? [])
        .where((m) => m.id != messageId)
        .toList();

    state = state.copyWith(
      messagesMap: {
        ...state.messagesMap,
        id: updated,
      },
    );
  }

  /// حذف للجميع
  void deleteForEveryone(
      String senderId,
      String receiverId,
      String messageId,
      ) {
    final id = chatId(senderId, receiverId);

    final messages =
    List<Message>.from(state.messagesMap[id] ?? []);

    final index =
    messages.indexWhere((m) => m.id == messageId);

    if (index != -1) {
      final message = messages[index];

      messages[index] = message.copyWith(
        text: "This message was deleted",
        fileUrl: null,
        deletedForEveryone: true,
      );
    }

    state = state.copyWith(
      messagesMap: {
        ...state.messagesMap,
        id: messages,
      },
    );
  }
}