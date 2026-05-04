import '../config/app_config.dart';

class ApiConstants {
  //  (لـ Schedule)
  static const String baseUrl = AppConfig.baseUrl;

  //  (لـ Auth, Users, Conversations)
  static const String apiBaseUrl = "http://192.168.1.9:5000/api";

  // Auth
  static String login() => "$apiBaseUrl/Auth/login";

  // Users
  static String getUsers() => "$apiBaseUrl/Users";
  static String searchUsers(String email) => "$apiBaseUrl/Users?email=$email";

  // Conversations
  static String getConversations() => "$apiBaseUrl/Conversations";

  static String getMessages(String userId, {int page = 1, int pageSize = 50}) =>
      "$apiBaseUrl/Conversations/$userId/messages?page=$page&pageSize=$pageSize";

  static String sendMessage(String receiverId) =>
      "$apiBaseUrl/Conversations/$receiverId/messages";

  static String markMessageAsRead(String userId, int messageId) =>
      "$apiBaseUrl/Conversations/$userId/messages/$messageId/read";

  static String markAllAsRead(String userId) =>
      "$apiBaseUrl/Conversations/$userId/read";

  //  (Schedules)
  static String get schedulesEndpoint => "/Schedules";
}