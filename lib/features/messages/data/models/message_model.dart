import '../../domain/entities/message.dart';

class MessageModel extends Message {

  const MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    required super.text,
    required super.createdAt,
    required super.deletedForEveryone,
  });

  factory MessageModel.fromEntity(Message message) {

    return MessageModel(
      id: message.id,
      senderId: message.senderId,
      receiverId: message.receiverId,
      text: message.text,
      createdAt: message.createdAt,
      deletedForEveryone: message.deletedForEveryone,
    );
  }
}