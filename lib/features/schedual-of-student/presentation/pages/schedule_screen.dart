/*import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/schedule_provider.dart';
import '../../domain/entities/schedule_item.dart';
import '../../domain/entities/day_schedule.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the state
    final state = ref.watch(scheduleNotifierProvider);
    // 2. Read the notifier to call methods
    final notifier = ref.read(scheduleNotifierProvider.notifier);

    // 3. Get data
    final schedule = notifier.displaySchedule;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  Text(
                    'School Schedule',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // Tabs
            _buildToggleButtons(context, state.currentViewIndex, notifier),
            SizedBox(height: 20.h),

            // List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount:
                    schedule.length + (state.currentViewIndex == 1 ? 1 : 0),
                itemBuilder: (context, index) {
                  if (state.currentViewIndex == 1 && index == schedule.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: SizedBox(
                          width: 280.w,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: const Text("Download full Schedule"),
                          ),
                        ),
                      ),
                    );
                  }

                  final day = schedule[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.currentViewIndex == 1)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                          child: Text(
                            day.dayName,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      // Items List
                      ...day.items.map((item) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: ScheduleCard(item: item),
                          ))
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: state.bottomNavIndex,
        onTap: notifier.setBottomNavIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: ''),
        ],
      ),
    );
  }

  Widget _buildToggleButtons(
      BuildContext context, int currentIndex, ScheduleNotifier notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: const Text("Daily"),
          selected: currentIndex == 0,
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onSelected: (_) => notifier.toggleView(0),
        ),
        SizedBox(width: 10.w),
        ChoiceChip(
          label: const Text("Weekly"),
          selected: currentIndex == 1,
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
          onSelected: (_) => notifier.toggleView(1),
        ),
      ],
    );
  }
}

// Card Widget
class ScheduleCard extends StatelessWidget {
  final ScheduleItem item;
  const ScheduleCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
        border:
            Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: item.iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(child: item.iconContent),
          ),
          const Spacer(),
          Text(item.time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
          const Spacer(),
          Expanded(
            child: Text(
              item.title,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/schedule_provider.dart';
import '../../domain/entities/schedule_item.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleNotifierProvider);
    final notifier = ref.read(scheduleNotifierProvider.notifier);

    final schedule = notifier.displaySchedule;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      appBar: const AppMainAppBar(
        title: "Schedule",
        centerTitle: false,
      ),

      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  Text(
                    'School Schedule',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Tabs
            _buildToggleButtons(context, state.currentViewIndex, notifier),

            SizedBox(height: 20.h),

            // List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount:
                schedule.length + (state.currentViewIndex == 1 ? 1 : 0),
                itemBuilder: (context, index) {
                  if (state.currentViewIndex == 1 && index == schedule.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: SizedBox(
                          width: 280.w,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Theme.of(context).colorScheme.primary,
                            ),
                            child: const Text("Download full Schedule"),
                          ),
                        ),
                      ),
                    );
                  }

                  final day = schedule[index];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.currentViewIndex == 1)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 5.h),
                          child: Text(
                            day.dayName,
                            style: TextStyle(
                              color:
                              Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),

                      ...day.items.map(
                            (item) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: ScheduleCard(item: item),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons(
      BuildContext context, int currentIndex, ScheduleNotifier notifier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: Text(
            "Daily",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          selected: currentIndex == 0,
          selectedColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onSelected: (_) => notifier.toggleView(0),
        ),
        SizedBox(width: 10.w),
        ChoiceChip(
          label: Text(
            "Weekly",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          selected: currentIndex == 1,
          selectedColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
          backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
          onSelected: (_) => notifier.toggleView(1),
        ),
      ],
    );
  }
}

// Card Widget
class ScheduleCard extends StatelessWidget {
  final ScheduleItem item;

  const ScheduleCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: item.iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(child: item.iconContent),
          ),

          const Spacer(),

          Text(
            item.time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          const Spacer(),

          Expanded(
            child: Text(
              item.title,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}