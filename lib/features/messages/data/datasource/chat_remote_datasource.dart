import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/message_model.dart';

class ChatRemoteDataSource {
  final http.Client client;
  ChatRemoteDataSource(this.client);

  final String baseUrl = "https://your-api.com";

  Future<List<MessageModel>> getMessages(String currentUserId, String otherUserId) async {
    final response = await client.get(Uri.parse("$baseUrl/messages/$currentUserId/$otherUserId"));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => MessageModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load messages");
    }
  }

  Future<void> sendMessage(MessageModel message) async {
    final response = await client.post(
      Uri.parse("$baseUrl/messages"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(message.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to send message");
    }
  }

  Future<void> deleteMessageForMe(String messageId) async {
    final response = await client.delete(Uri.parse("$baseUrl/messages/me/$messageId"));
    if (response.statusCode != 200) throw Exception("Failed to delete message");
  }

  Future<void> deleteMessageForEveryone(String messageId) async {
    final response = await client.delete(Uri.parse("$baseUrl/messages/all/$messageId"));
    if (response.statusCode != 200) throw Exception("Failed to delete for everyone");
  }

  Future<void> markAsSeen(String messageId) async {
    final response = await client.patch(Uri.parse("$baseUrl/messages/seen/$messageId"));
    if (response.statusCode != 200) throw Exception("Failed to mark as seen");
  }

  Future<void> updateUserStatus(String userId, String status) async {
    final response = await client.patch(
      Uri.parse("$baseUrl/users/status/$userId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"status": status}),
    );
    if (response.statusCode != 200) throw Exception("Failed to update status");
  }
}