import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

      await controller.loadNotifications();
      await controller.markAllAsRead();
    });
  }

  @override
  Widget build(BuildContext context) {

    final notifications =
    ref.watch(notificationsControllerProvider);

    final controller =
    ref.read(notificationsControllerProvider.notifier);

    final today = <AppNotification>[];
    final yesterday = <AppNotification>[];
    final earlier = <AppNotification>[];

    final now = DateTime.now();

    /// تقسيم الإشعارات
    for (final n in notifications) {

      final diff = now.difference(n.createdAt);

      if (diff.inDays == 0) {
        today.add(n);
      } else if (diff.inDays == 1) {
        yesterday.add(n);
      } else {
        earlier.add(n);
      }
    }

    return Scaffold(

      appBar: AppMainAppBar(
        title: "Notifications",
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

      ///للتجربة
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(notificationsControllerProvider.notifier)
              .addFakeNotification();
        },

        ////
        child: const Icon(Icons.add),
      ),

      body: notifications.isEmpty
          ? const Center(
        child: Text("No Notifications"),
      )

          : ListView(
        padding: EdgeInsets.all(16.w),
        children: [

          /// Header Row (Clear All هنا)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "Recent",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              GestureDetector(
                onTap: () {
                  controller.clearAll();
                },

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Text(
                    "Clear All",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),

          SizedBox(height: 18.h),

          /// Today
          if (today.isNotEmpty)
            _buildSection(
              "Today",
              today,
            ),

          /// Yesterday
          if (yesterday.isNotEmpty)
            _buildSection(
              "Yesterday",
              yesterday,
            ),

          /// Earlier
          if (earlier.isNotEmpty)
            _buildSection(
              "Earlier",
              earlier,
            ),
        ],
      ),
    );
  }

  Widget _buildSection(
      String title,
      List<AppNotification> notifications,
      ) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),

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

            duration: const Duration(milliseconds: 300),

            curve: Curves.easeInOut,

            child: NotificationTile(
              notification: n,
            ),
          ),
        ),


        SizedBox(height: 12.h),
      ],
    );
  }
}
