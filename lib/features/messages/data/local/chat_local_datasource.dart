import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChatLocalDatasource {

  Future<void> saveMessages(String chatId, List<Map<String, dynamic>> messages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(chatId, jsonEncode(messages));
  }

  Future<List<Map<String, dynamic>>> loadMessages(String chatId) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(chatId);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List;

    return decoded.cast<Map<String, dynamic>>();
  }
}
