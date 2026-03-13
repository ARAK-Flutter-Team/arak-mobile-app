/*import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/get_notification_status.dart';
import '../../domain/usecases/mark_notifications_as_seen.dart';
import '../../data/datasources/notification_local_datasource.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';

/// ----------------------------------------------------------------
/// Temporary Remote Implementation (يتشال لما الباك ييجي)
/// ----------------------------------------------------------------
class FakeNotificationRemoteDataSource
    implements NotificationRemoteDataSource {
  @override
  Future<int> getLatestTaskId() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 10; // تجريبي
  }

  @override
  Future<int> getLatestMessageId() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 5; // تجريبي
  }
}

/// ----------------------------------------------------------------
/// Repository Provider (Dependency Injection)
/// ----------------------------------------------------------------
final notificationRepositoryProvider =
Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    local: NotificationLocalDataSource(),
    remote: FakeNotificationRemoteDataSource(),
  );
});

/// ----------------------------------------------------------------
/// UI State (مخصص للـ Presentation فقط)
/// ----------------------------------------------------------------
class NotificationUIState {
  final bool hasNewTasks;
  final bool hasNewMessages;

  const NotificationUIState({
    required this.hasNewTasks,
    required this.hasNewMessages,
  });
}

/// ----------------------------------------------------------------
/// AsyncNotifier Provider
/// ----------------------------------------------------------------
final notificationProvider =
AsyncNotifierProvider<NotificationNotifier, NotificationUIState>(
  NotificationNotifier.new,
);

class NotificationNotifier
    extends AsyncNotifier<NotificationUIState> {

  late final GetNotificationStatus _getStatusUseCase;
  late final MarkNotificationsAsSeen _markSeenUseCase;
  late final NotificationRepository _repository;

  @override
  Future<NotificationUIState> build() async {
    _repository = ref.read(notificationRepositoryProvider);

    _getStatusUseCase = GetNotificationStatus(_repository);
    _markSeenUseCase = MarkNotificationsAsSeen(_repository);

    final hasTasks = await _getStatusUseCase.hasNewTasks();
    final hasMessages = await _getStatusUseCase.hasNewMessages();

    return NotificationUIState(
      hasNewTasks: hasTasks,
      hasNewMessages: hasMessages,
    );
  }

  /// ----------------------------------------------------------------
  /// Mark Tasks as Seen
  /// ----------------------------------------------------------------
  Future<void> markTasksAsSeen() async {
    final latestId = await _repository.getLatestTaskId();
    await _markSeenUseCase.markTasksSeen(latestId);

    ref.invalidateSelf(); // يعيد حساب الحالة
  }

  /// ----------------------------------------------------------------
  /// Mark Messages as Seen
  /// ----------------------------------------------------------------
  Future<void> markMessagesAsSeen() async {
    final latestId = await _repository.getLatestMessageId();
    await _markSeenUseCase.markMessagesSeen(latestId);

    ref.invalidateSelf();
  }
}*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/notification_repository.dart';
import '../../domain/usecases/get_notification_status.dart';
import '../../domain/usecases/mark_notifications_as_seen.dart';

import '../../data/datasources/notification_local_datasource.dart';
import '../../data/datasources/notification_remote_datasource.dart';
import '../../data/repositories/notification_repository_impl.dart';

/// ------------------------------------------------------------
/// Fake Remote (يتشال لما الباك ييجي)
/// ------------------------------------------------------------
class FakeNotificationRemoteDataSource
    implements NotificationRemoteDataSource {

  @override
  Future<int> getLatestTaskId() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 10;
  }

  @override
  Future<int> getLatestMessageId() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 5;
  }
}

/// ------------------------------------------------------------
/// Repository Provider
/// ------------------------------------------------------------
final notificationRepositoryProvider =
Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    local: NotificationLocalDataSource(),
    remote: FakeNotificationRemoteDataSource(),
  );
});

/// ------------------------------------------------------------
/// UI State
/// ------------------------------------------------------------
class NotificationUIState {
  final bool hasNewTasks;
  final bool hasNewMessages;

  const NotificationUIState({
    required this.hasNewTasks,
    required this.hasNewMessages,
  });

  NotificationUIState copyWith({
    bool? hasNewTasks,
    bool? hasNewMessages,
  }) {
    return NotificationUIState(
      hasNewTasks: hasNewTasks ?? this.hasNewTasks,
      hasNewMessages: hasNewMessages ?? this.hasNewMessages,
    );
  }
}

/// ------------------------------------------------------------
/// Provider
/// ------------------------------------------------------------
final notificationProvider =
AsyncNotifierProvider<NotificationNotifier, NotificationUIState>(
    NotificationNotifier.new);

/// ------------------------------------------------------------
/// Notifier
/// ------------------------------------------------------------
class NotificationNotifier extends AsyncNotifier<NotificationUIState> {

  late final GetNotificationStatus _getStatusUseCase;
  late final MarkNotificationsAsSeen _markSeenUseCase;
  late final NotificationRepository _repository;

  /// ------------------------------------------------------------
  /// Build
  /// ------------------------------------------------------------
  @override
  Future<NotificationUIState> build() async {

    _repository = ref.read(notificationRepositoryProvider);

    _getStatusUseCase = GetNotificationStatus(_repository);
    _markSeenUseCase = MarkNotificationsAsSeen(_repository);

    final hasTasks = await _getStatusUseCase.hasNewTasks();
    final hasMessages = await _getStatusUseCase.hasNewMessages();

    return NotificationUIState(
      hasNewTasks: hasTasks,
      hasNewMessages: hasMessages,
    );
  }

  /// ------------------------------------------------------------
  /// Mark Tasks as Seen
  /// ------------------------------------------------------------
  Future<void> markTasksAsSeen() async {

    final latestId = await _repository.getLatestTaskId();

    await _markSeenUseCase.markTasksSeen(latestId);

    state = AsyncData(
      state.value!.copyWith(
        hasNewTasks: false,
      ),
    );
  }

  /// ------------------------------------------------------------
  /// Mark Messages as Seen
  /// ------------------------------------------------------------
  Future<void> markMessagesAsSeen() async {

    final latestId = await _repository.getLatestMessageId();

    await _markSeenUseCase.markMessagesSeen(latestId);

    state = AsyncData(
      state.value!.copyWith(
        hasNewMessages: false,
      ),
    );
  }
}