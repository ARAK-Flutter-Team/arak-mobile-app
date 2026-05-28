import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arak_app/core/network/dio_provider.dart';
import '../../data/datasources/notification_remote_datasource_impl.dart';
import '../../data/repositories/notification_repository_impl.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/get_unread_count.dart';
import '../../domain/usecases/mark_all_as_read.dart';

// ✅ unread count provider
final unreadNotificationsProvider = StateProvider<int>((ref) => 0);

// ── DataSource — uses dioProvider (token interceptor included)
final _notificationDataSourceProvider =
    Provider<NotificationRemoteDataSourceImpl>((ref) {
  return NotificationRemoteDataSourceImpl(ref.watch(dioProvider));
});

// ── Repository
// ✅ صح — بيبعت الـ datasource
final _notificationRepositoryProvider =
    Provider<NotificationsRepositoryImpl>((ref) {
  return NotificationsRepositoryImpl(
      ref.watch(_notificationDataSourceProvider));
});

// ── UseCases
final getNotificationsUseCaseProvider =
    Provider<GetNotificationsUseCase>((ref) {
  return GetNotificationsUseCase(ref.watch(_notificationRepositoryProvider));
});

final getUnreadCountUseCaseProvider = Provider<GetUnreadCountUseCase>((ref) {
  return GetUnreadCountUseCase(ref.watch(_notificationRepositoryProvider));
});

final markAllAsReadUseCaseProvider = Provider<MarkAllAsReadUseCase>((ref) {
  return MarkAllAsReadUseCase(ref.watch(_notificationRepositoryProvider));
});

// ── Controller (unchanged)
class NotificationsController
    extends StateNotifier<AsyncValue<List<AppNotification>>> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final GetUnreadCountUseCase getUnreadCountUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  final Ref ref;

  NotificationsController({
    required this.getNotificationsUseCase,
    required this.getUnreadCountUseCase,
    required this.markAllAsReadUseCase,
    required this.ref,
  }) : super(const AsyncData([]));

  Future<void> loadNotifications() async {
    state = const AsyncLoading();
    try {
      final notifications = await getNotificationsUseCase();
      state = AsyncData(notifications);
      final count = await getUnreadCountUseCase();
      ref.read(unreadNotificationsProvider.notifier).state = count;
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await markAllAsReadUseCase();
      state = state.whenData(
        (list) => list.map((n) => n.copyWith(isRead: true)).toList(),
      );
      ref.read(unreadNotificationsProvider.notifier).state = 0;
    } catch (_) {}
  }

  void clearAll() {
    state = const AsyncData([]);
  }
}

final notificationsControllerProvider = StateNotifierProvider<
    NotificationsController, AsyncValue<List<AppNotification>>>((ref) {
  return NotificationsController(
    getNotificationsUseCase: ref.watch(getNotificationsUseCaseProvider),
    getUnreadCountUseCase: ref.watch(getUnreadCountUseCaseProvider),
    markAllAsReadUseCase: ref.watch(markAllAsReadUseCaseProvider),
    ref: ref,
  );
});
