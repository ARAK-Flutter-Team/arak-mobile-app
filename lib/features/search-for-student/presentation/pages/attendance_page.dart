import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../providers/attendance_provider.dart';
import 'package:arak_app/features/parent_home/presentation/providers/parent_home_provider.dart';

class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedStudent = ref.watch(selectedStudentProvider);
    final studentId = selectedStudent?.numericId ?? 0;
    final attendanceAsync = ref.watch(attendanceProvider(studentId));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppMainAppBar(
        title: l10n.attendanceDetails, // ✅
        centerTitle: false,
      ),
      body: attendanceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StudentInfoCard(data: data),
              const SizedBox(height: 20),
              TimeAttendanceCard(data: data),
              const SizedBox(height: 20),
              StatsOverviewRow(data: data),
              const SizedBox(height: 20),
              Text(
                l10n.attendanceCalendar, // ✅
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              AttendanceCalendar(initialMonth: DateTime(2024, 10, 1)),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  l10n.lastUpdated(data.checkOut), // ✅
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── StudentInfoCard ─────────────────────────────────────────
class StudentInfoCard extends StatelessWidget {
  final StudentAttendance data;
  const StudentInfoCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.grade,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data.status,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── TimeBox ─────────────────────────────────────────────────
class TimeBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final MaterialColor color;

  const TimeBox({
    required this.icon,
    required this.label,
    required this.time,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── TimeAttendanceCard ───────────────────────────────────────
class TimeAttendanceCard extends StatelessWidget {
  final StudentAttendance data;
  const TimeAttendanceCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: <Widget>[
        Expanded(
          child: TimeBox(
            icon: Icons.login,
            label: l10n.checkIn, // ✅
            time: data.checkIn,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TimeBox(
            icon: Icons.logout,
            label: l10n.checkOut, // ✅
            time: data.checkOut,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

// ── StatItem ─────────────────────────────────────────────────
class StatItem extends StatelessWidget {
  final String value;
  final String label;
  final double progress;
  final MaterialColor color;

  const StatItem({
    required this.value,
    required this.label,
    required this.progress,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                backgroundColor: color.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

// ── StatsOverviewRow ─────────────────────────────────────────
class StatsOverviewRow extends StatelessWidget {
  final StudentAttendance data;
  const StatsOverviewRow({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        StatItem(
          value: "${data.attendanceRate}%",
          label: l10n.attendance, // ✅
          progress: data.attendanceRate / 100.0,
          color: Colors.blue,
        ),
        StatItem(
          value: data.lateTimes.toString(),
          label: l10n.late, // ✅
          progress: data.lateTimes / 10.0,
          color: Colors.orange,
        ),
        StatItem(
          value: data.absentTimes.toString(),
          label: l10n.absent, // ✅
          progress: data.absentTimes / 10.0,
          color: Colors.red,
        ),
      ],
    );
  }
}

// ── AttendanceCalendar ───────────────────────────────────────
class AttendanceCalendar extends StatefulWidget {
  final DateTime initialMonth;

  const AttendanceCalendar({
    required this.initialMonth,
    super.key,
  });

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth =
        DateTime(widget.initialMonth.year, widget.initialMonth.month, 1);
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    const daysOfWeek = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    final firstDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstDayVisualOffset = (firstDayOfMonth.weekday % 7);
    final totalDaysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    int totalCells = (firstDayVisualOffset + totalDaysInMonth + 6) ~/ 7 * 7;

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left, size: 20),
                    onPressed: () => setState(
                      () => _currentMonth = DateTime(
                          _currentMonth.year, _currentMonth.month - 1, 1),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right, size: 20),
                    onPressed: () => setState(
                      () => _currentMonth = DateTime(
                          _currentMonth.year, _currentMonth.month + 1, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek
                .map((e) => Expanded(
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: totalCells,
            itemBuilder: (context, index) {
              final day = index - firstDayVisualOffset + 1;
              if (day < 1 || day > totalDaysInMonth) return Container();

              final now = DateTime.now();
              final isToday = day == now.day &&
                  _currentMonth.month == now.month &&
                  _currentMonth.year == now.year;

              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isToday
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 14,
                    color: isToday
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
