import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/schedule_item.dart';
import '../providers/schedule_providers.dart';
import '../providers/schedule_state.dart';
import '../widgets/schedule_day_section.dart';
import '../widgets/schedule_header.dart';

class TeacherSchedulePage extends ConsumerStatefulWidget {
  //final int teacherId;

  const TeacherSchedulePage({
    super.key,
   // required this.teacherId,
  });

  @override
  ConsumerState<TeacherSchedulePage> createState() =>
      _TeacherSchedulePageState();
}

class _TeacherSchedulePageState
    extends ConsumerState<TeacherSchedulePage> {

  final List<String> daysOrder = const [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final user = ref.read(authProvider).user;

      if (user != null) {
        ref
            .read(scheduleNotifierProvider.notifier)
            .loadSchedule(user.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scheduleNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          const AppMainAppBar(
            title: "My Weekly Schedule",
            showBackButton: true,
          ),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ScheduleState state) {
    if (state is ScheduleLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ScheduleError) {
      return Center(child: Text(state.message));
    }

    if (state is ScheduleLoaded) {
      final schedule = state.schedule;

      /// Grouping by day
      final Map<String, List<ScheduleItem>> grouped = {};

      for (var item in schedule) {
        grouped.putIfAbsent(item.day, () => []);
        grouped[item.day]!.add(item);
      }

      return SingleChildScrollView(
        padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScheduleHeader(),

            ...daysOrder.map((day) {
              final items = grouped[day] ?? [];
              if (items.isEmpty) {
                return const SizedBox.shrink();
              }

              return ScheduleDaySection(
                day: day,
                items: items,
              );
            }),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}