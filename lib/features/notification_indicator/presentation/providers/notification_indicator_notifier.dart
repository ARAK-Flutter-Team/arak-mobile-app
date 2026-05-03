import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../notifications/presentation/providers/notifications_provider.dart';
import '../state/notification_ui_state.dart';

// ✅ Single source of truth: derived from the real API-backed unreadNotificationsProvider.
// When NotificationsPage loads and calls getUnreadCount(), this rebuilds automatically.
final notificationProvider = Provider<NotificationUIState>((ref) {
  final unreadCount = ref.watch(unreadNotificationsProvider);
  return NotificationUIState(hasUnread: unreadCount > 0);
});