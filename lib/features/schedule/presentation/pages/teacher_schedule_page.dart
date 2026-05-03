import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/schedule_filters.dart';
import '../../domain/entities/schedule_item.dart';
import '../providers/schedule_filter_provider.dart';
import '../providers/schedule_providers.dart';
import '../providers/schedule_state.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/schedule_day_section.dart';
import '../widgets/schedule_header.dart';

class TeacherSchedulePage extends ConsumerStatefulWidget {
  const TeacherSchedulePage({super.key});

  @override
  ConsumerState<TeacherSchedulePage> createState() =>
      _TeacherSchedulePageState();
}

class _TeacherSchedulePageState extends ConsumerState<TeacherSchedulePage> {
  final List<String> daysOrder = const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  String getTranslatedDay(String day) {
    final loc = AppLocalizations.of(context)!;
    switch (day) {
      case 'Sunday':
        return loc.sunday;
      case 'Monday':
        return loc.monday;
      case 'Tuesday':
        return loc.tuesday;
      case 'Wednesday':
        return loc.wednesday;
      case 'Thursday':
        return loc.thursday;
      case 'Friday':
        return loc.friday;
      case 'Saturday':
        return loc.saturday;
      default:
        return day;
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(teacherScheduleNotifierProvider.notifier).loadSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(teacherScheduleNotifierProvider);
    final filters = ref.watch(scheduleFiltersProvider);
    final loc = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    ref.listen<ScheduleFilters>(scheduleFiltersProvider, (prev, next) {
      if (prev != next) {
        ref.read(teacherScheduleNotifierProvider.notifier).loadSchedules();
      }
    });

    return Scaffold(
      appBar: AppMainAppBar(
        title: loc.myWeeklySchedule,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: isDarkMode ? Colors.white : null,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => const ScheduleFilterSheet(),
              );
            },
          ),
        ],
      ),
      body: _buildBody(state, filters, loc),
    );
  }

  Widget _buildBody(
    ScheduleState state,
    ScheduleFilters filters,
    AppLocalizations loc,
  ) {
    if (state is ScheduleLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ScheduleError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(state.message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(teacherScheduleNotifierProvider.notifier).loadSchedules();
              },
              child: Text(loc.tryAgain),
            ),
          ],
        ),
      );
    }

    if (state is ScheduleLoaded) {
      final schedule = state.schedule;

      if (schedule.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.schedule, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                loc.noScheduleFound,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (_hasActiveFilters(filters))
                ElevatedButton(
                  onPressed: () {
                    ref.read(scheduleFilterControllerProvider).clearFilters();
                  },
                  child: Text(loc.clearFilters),
                ),
            ],
          ),
        );
      }

      final Map<String, List<ScheduleItem>> grouped = {};
      for (var item in schedule) {
        final dayKey = item.dayName;
        grouped.putIfAbsent(dayKey, () => []);
        grouped[dayKey]!.add(item);
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScheduleHeader(),
            if (_hasActiveFilters(filters))
              _buildActiveFiltersChips(filters, loc),
            ...daysOrder.map((day) {
              final items = grouped[day] ?? [];
              if (items.isEmpty) return const SizedBox.shrink();
              return ScheduleDaySection(
                day: getTranslatedDay(day),
                items: items,
              );
            }),
          ],
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }

  bool _hasActiveFilters(ScheduleFilters filters) {
    return filters.classId != null || filters.teacherId != null;
  }

  Widget _buildActiveFiltersChips(ScheduleFilters filters, AppLocalizations loc) {
    final controller = ref.read(scheduleFilterControllerProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final chipColor = isDarkMode ? Colors.grey[800] : Colors.grey[200];
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loc.activeFilters,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (filters.classId != null)
                Chip(
                  backgroundColor: chipColor,
                  label: Text(
                    '${loc.classLabel}: ${filters.classId}',
                    style: TextStyle(color: textColor),
                  ),
                  onDeleted: () => controller.updateFilter(classId: null),
                  deleteIconColor: textColor,
                ),
              if (filters.teacherId != null)
                Chip(
                  backgroundColor: chipColor,
                  label: Text(
                    'Teacher ID: ${filters.teacherId}',
                    style: TextStyle(color: textColor),
                  ),
                  onDeleted: () => controller.updateFilter(teacherId: null),
                  deleteIconColor: textColor,
                ),
            ],
          ),
        ],
      ),
    );
  }
}