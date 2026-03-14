/*import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';

class MessageModel extends Message {

  MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    super.text,
    super.fileUrl,
    super.duration,
    required super.type,
    required super.status,
    required super.createdAt,
    required super.deletedForEveryone,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {

    return MessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',

      text: json['text'],
      fileUrl: json['fileUrl'],

      duration: json['duration'] != null
          ? json['duration'] as int
          : null,

      type: MessageType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),

      status: MessageStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => MessageStatus.sent,
      ),

      createdAt: DateTime.parse(json['createdAt']),

      deletedForEveryone: json['deletedForEveryone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,

      "text": text,
      "fileUrl": fileUrl,

      "duration": duration,

      "type": type.name,
      "status": status.name,

      "createdAt": createdAt.toIso8601String(),

      "deletedForEveryone": deletedForEveryone,
    };
  }
}*/
import '../../domain/entities/message.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';

class MessageModel extends Message {
  MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    super.text,
    super.fileUrl,
    super.duration,
    required super.type,
    required super.status,
    required super.createdAt,
    required super.deletedForEveryone,
    super.replyToMessageId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',

      text: json['text'],
      fileUrl: json['fileUrl'],

      duration: json['duration'],

      type: MessageType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => MessageType.text,
      ),

      status: MessageStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => MessageStatus.sent,
      ),

      createdAt: DateTime.parse(json['createdAt']),

      deletedForEveryone: json['deletedForEveryone'] ?? false,

      replyToMessageId: json['replyToMessageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "senderId": senderId,
      "receiverId": receiverId,

      "text": text,
      "fileUrl": fileUrl,

      "duration": duration,

      "type": type.name,
      "status": status.name,

      "createdAt": createdAt.toIso8601String(),

      "deletedForEveryone": deletedForEveryone,

      "replyToMessageId": replyToMessageId,
    };
  }
}