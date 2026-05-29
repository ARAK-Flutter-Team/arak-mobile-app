import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';

import '../../domain/entities/notification.dart';
import '../providers/notifications_provider.dart';
import '../widgets/notification_tile.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState
    extends ConsumerState<NotificationsPage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {

      final controller =
      ref.read(notificationsControllerProvider.notifier);

      /// تحميل الإشعارات
      await controller.loadNotifications();

      /// تعليم الإشعارات كمقروءة
      await controller.markAllAsRead();

      /// تصفير الكاونتر
      ref.read(unreadNotificationsProvider.notifier).state = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    final loc = AppLocalizations.of(context)!;

    final controller =
    ref.read(notificationsControllerProvider.notifier);

    final notificationsState =
    ref.watch(notificationsControllerProvider);

    return Scaffold(

      appBar: AppMainAppBar(
        title: loc.notifications,
        centerTitle: false,
        showBackButton: false,
        disableDefaultLeading: true,

        leadingWidget: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Icon(
            Icons.notifications,
            size: 26.sp,
          ),
        ),
      ),

      body: notificationsState.when(

        /// Loading
        loading: () =>
        const Center(
          child: CircularProgressIndicator(),
        ),

        /// Error
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),

              const SizedBox(height: 12),

              Text(
                'حدث خطأ، حاول مرة أخرى',
                style: TextStyle(fontSize: 16.sp),
              ),

              const SizedBox(height: 6),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),

                child: Text(
                  e.toString(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    controller.loadNotifications(),

                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),

        /// Data
        data: (notifications) {

          if (notifications.isEmpty) {
            return Center(
              child: Text(loc.noNotifications),
            );
          }

          final today = <AppNotification>[];
          final yesterday = <AppNotification>[];
          final earlier = <AppNotification>[];

          final now = DateTime.now();

          for (final n in notifications) {

            final diff =
            now.difference(n.createdAt);

            if (diff.inDays == 0) {

              today.add(n);

            } else if (diff.inDays == 1) {

              yesterday.add(n);

            } else {

              earlier.add(n);
            }
          }

          return ListView(

            padding: EdgeInsets.all(16.w),

            children: [

              /// Header
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  Text(
                    loc.recent,

                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(

                    onTap: () async {

                      /// تعليم الكل كمقروء
                      await controller.markAllAsRead();

                      /// حذفهم من الـ UI
                      controller.clearAll();
                    },

                    child: Container(

                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color:
                        Colors.red.withOpacity(.1),

                        borderRadius:
                        BorderRadius.circular(20),
                      ),

                      child: Text(

                        loc.clearAll,

                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              if (today.isNotEmpty)
                _buildSection(loc.today, today),

              if (yesterday.isNotEmpty)
                _buildSection(
                  loc.yesterday,
                  yesterday,
                ),

              if (earlier.isNotEmpty)
                _buildSection(
                  loc.earlier,
                  earlier,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(
      String title,
      List<AppNotification> notifications,
      ) {

    return Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Padding(
          padding:
          EdgeInsets.symmetric(vertical: 10.h),

          child: Text(

            title,

            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ...notifications.map(

              (n) => AnimatedContainer(

            duration:
            const Duration(milliseconds: 300),

            curve: Curves.easeInOut,

            child:
            NotificationTile(notification: n),
          ),
        ),

        SizedBox(height: 12.h),
      ],
    );
  }
}