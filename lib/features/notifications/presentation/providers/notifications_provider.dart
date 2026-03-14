import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/get_unread_count.dart';
import '../../domain/usecases/mark_all_as_read.dart';

/// UseCases Providers

final getNotificationsUseCaseProvider =
Provider<GetNotificationsUseCase>((ref) {

  final repo = NotificationsRepositoryImpl();

  return GetNotificationsUseCase(repo);
});

final getUnreadCountUseCaseProvider =
Provider<GetUnreadCountUseCase>((ref) {

  final repo = NotificationsRepositoryImpl();

  return GetUnreadCountUseCase(repo);
});

final markAllAsReadUseCaseProvider =
Provider<MarkAllAsReadUseCase>((ref) {

  final repo = NotificationsRepositoryImpl();

  return MarkAllAsReadUseCase(repo);
});


/// Controller

class NotificationsController
    extends StateNotifier<List<AppNotification>> {

  final GetNotificationsUseCase getNotificationsUseCase;
  final GetUnreadCountUseCase getUnreadCountUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;

  NotificationsController({
    required this.getNotificationsUseCase,
    required this.getUnreadCountUseCase,
    required this.markAllAsReadUseCase,
  }) : super([]);

  Future<void> loadNotifications() async {

    final notifications = await getNotificationsUseCase();

    state = notifications;
  }

  Future<int> getUnreadCount() async {

    return await getUnreadCountUseCase();
  }

  Future<void> markAllAsRead() async {

    await markAllAsReadUseCase();

    state = [
      for (final n in state)
        n.copyWith(isRead: true)
    ];

    final repo = NotificationsRepositoryImpl();

    await repo.saveNotifications(state);
  }


  /// Clear All
  void clearAll() async {

    state = [];

    final repo = NotificationsRepositoryImpl();

    await repo.saveNotifications([]);
  }

}

/// Provider الأساسي

final notificationsControllerProvider =
StateNotifierProvider<NotificationsController, List<AppNotification>>((ref) {

  final getNotifications = ref.watch(getNotificationsUseCaseProvider);

  final getUnread = ref.watch(getUnreadCountUseCaseProvider);

  final markRead = ref.watch(markAllAsReadUseCaseProvider);

  return NotificationsController(
    getNotificationsUseCase: getNotifications,
    getUnreadCountUseCase: getUnread,
    markAllAsReadUseCase: markRead,
  );
});
