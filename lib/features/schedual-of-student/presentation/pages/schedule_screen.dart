// lib/features/schedual-of-student/presentation/pages/schedule_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../providers/schedule_provider.dart';
import '../../domain/entities/schedule_item.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(scheduleNotifierProvider.notifier).loadParentSchedule());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(scheduleNotifierProvider);
    final notifier = ref.read(scheduleNotifierProvider.notifier);
    final schedule = notifier.displaySchedule;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppMainAppBar(
        title: l10n.schedule,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                children: [
                  Text(
                    l10n.schoolSchedule,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            _buildToggleButtons(context, state.currentViewIndex, notifier),
            SizedBox(height: 20.h),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.error != null
                      ? Center(child: Text(state.error!))
                      : schedule.isEmpty
                          ? Center(
                              child: Text(
                                'No schedule available',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              itemCount: schedule.length +
                                  (state.currentViewIndex == 1 ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (state.currentViewIndex == 1 &&
                                    index == schedule.length) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Center(
                                      child: SizedBox(
                                        width: 280.w,
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          child:
                                              Text(l10n.downloadFullSchedule),
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
                                        padding: EdgeInsets.only(
                                            top: 10.h, bottom: 5.h),
                                        child: Text(
                                          day.dayName,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                    ),
                                  ],
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons(
      BuildContext context, int currentIndex, ScheduleNotifier notifier) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChoiceChip(
          label: Text(
            l10n.daily,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          selected: currentIndex == 0,
          selectedColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          onSelected: (_) => notifier.toggleView(0),
        ),
        SizedBox(width: 10.w),
        ChoiceChip(
          label: Text(
            l10n.weekly,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
          selected: currentIndex == 1,
          selectedColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          onSelected: (_) => notifier.toggleView(1),
        ),
      ],
    );
  }
}

// ── ScheduleCard ──────────────────────────────────────────────
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
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── الأيقونة ──
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: item.iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(child: item.iconContent),
          ),
          SizedBox(width: 12.w), // ✅ بدل Spacer

          // ── الوقت ── في المنتصف
          Expanded(
            child: Text(
              item.time,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          // ── اسم المادة ── على اليمين بمساحة ثابتة ✅
          SizedBox(
            width: 100.w,
            child: Text(
              item.title,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
