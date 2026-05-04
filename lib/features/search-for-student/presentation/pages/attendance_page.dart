import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_main_appbar.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../providers/attendance_provider.dart';
import 'package:arak_app/features/parent_home/presentation/providers/parent_home_provider.dart';

// ── AttendancePage ───────────────────────────────────────────
class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key});

  @override
  ConsumerState<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  late DateTime _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selectedStudent = ref.watch(selectedStudentProvider);
    final studentId = selectedStudent?.numericId ?? 0;

    final params = AttendanceParams(
      studentId: studentId,
      month: _selectedMonth.month,
      year: _selectedMonth.year,
    );
    final attendanceAsync = ref.watch(attendanceProvider(params));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppMainAppBar(
        title: l10n.attendanceDetails,
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
                l10n.attendanceCalendar,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              AttendanceCalendar(
                initialMonth: _selectedMonth,
                records: data.records,
                onMonthChanged: (newMonth) {
                  setState(() => _selectedMonth = newMonth);
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '${l10n.lastUpdate}: ${data.checkOut}',
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

  Color _statusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Late':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(data.status);

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
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data.status,
              style: TextStyle(
                color: statusColor,
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
            label: l10n.checkIn,
            time: data.checkIn,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TimeBox(
            icon: Icons.logout,
            label: l10n.checkOut,
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
                value: progress.clamp(0.0, 1.0),
                strokeWidth: 6,
                backgroundColor: color.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
          value: "${data.attendanceRate.toStringAsFixed(0)}%",
          label: l10n.attendance,
          progress: data.attendanceRate / 100.0,
          color: Colors.blue,
        ),
        StatItem(
          value: data.lateTimes.toString(),
          label: l10n.late,
          progress: (data.lateTimes / 10.0).clamp(0.0, 1.0),
          color: Colors.orange,
        ),
        StatItem(
          value: data.absentTimes.toString(),
          label: l10n.absent,
          progress: (data.absentTimes / 10.0).clamp(0.0, 1.0),
          color: Colors.red,
        ),
      ],
    );
  }
}

// ── AttendanceCalendar ───────────────────────────────────────
class AttendanceCalendar extends StatefulWidget {
  final DateTime initialMonth;
  final List<AttendanceDayRecord> records;
  final void Function(DateTime) onMonthChanged;

  const AttendanceCalendar({
    required this.initialMonth,
    required this.records,
    required this.onMonthChanged,
    super.key,
  });

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  late DateTime _currentMonth;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _currentMonth =
        DateTime(widget.initialMonth.year, widget.initialMonth.month, 1);
    // Initialize selected day as today if it's within the current month
    final now = DateTime.now();
    if (now.month == _currentMonth.month && now.year == _currentMonth.year) {
      _selectedDay = DateTime(now.year, now.month, now.day);
    }
  }

  @override
  void didUpdateWidget(AttendanceCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialMonth != widget.initialMonth) {
      _currentMonth =
          DateTime(widget.initialMonth.year, widget.initialMonth.month, 1);
    }
  }

  Map<String, String> get _recordMap {
    return {
      for (final r in widget.records)
        '${r.date.year}-${r.date.month}-${r.date.day}': r.status.toLowerCase()
    };
  }

  Color _getAttendanceColor(String? status) {
    if (status == null) return Colors.transparent;
    switch (status.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.orange;
      default:
        return Colors.transparent;
    }
  }

  BoxDecoration _buildDayDecoration({
    required bool isSelected,
    required bool isToday,
    required String? status,
    required Color statusColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 1. Determine base color (Priority: Status fill > Selection tint)
    Color bgColor = Colors.transparent;
    if (status != null && statusColor != Colors.transparent) {
      bgColor = statusColor.withOpacity(0.15);
    } else if (isSelected) {
      bgColor = colorScheme.primary.withOpacity(0.1);
    }

    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
      // 2. Borders (Priority: Today border > Status border)
      border: isToday
          ? Border.all(color: colorScheme.primary, width: 1.5)
          : (isSelected
              ? Border.all(color: colorScheme.primary.withOpacity(0.5), width: 1)
              : (status != null && statusColor != Colors.transparent
                  ? Border.all(color: statusColor.withOpacity(0.3), width: 1)
                  : null)),
    );
  }

  TextStyle _buildDayTextStyle({
    required bool isSelected,
    required bool isToday,
    required String? status,
    required Color statusColor,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use status color only if it's a valid semantic color
    final bool hasValidStatus = status != null && statusColor != Colors.transparent;

    return TextStyle(
      fontSize: 14,
      fontWeight: (hasValidStatus || isToday || isSelected)
          ? FontWeight.bold
          : FontWeight.normal,
      // Color priority: Status > Today > Selection > Default
      color: hasValidStatus
          ? statusColor
          : isToday
              ? colorScheme.primary
              : isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurface,
    );
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
    final firstDayVisualOffset = firstDayOfMonth.weekday % 7;
    final totalDaysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final totalCells = (firstDayVisualOffset + totalDaysInMonth + 6) ~/ 7 * 7;
    final recordMap = _recordMap;

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
          // ── Header ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${_getMonthName(_currentMonth.month)} ${_currentMonth.year}',
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
                    onPressed: () {
                      final newMonth =
                          DateTime(_currentMonth.year, _currentMonth.month - 1);
                      setState(() => _currentMonth = newMonth);
                      widget.onMonthChanged(newMonth);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_right, size: 20),
                    onPressed: () {
                      final newMonth =
                          DateTime(_currentMonth.year, _currentMonth.month + 1);
                      setState(() => _currentMonth = newMonth);
                      widget.onMonthChanged(newMonth);
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ── Legend ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(color: Colors.green, label: 'Present'),
              const SizedBox(width: 12),
              _LegendItem(color: Colors.red, label: 'Absent'),
              const SizedBox(width: 12),
              _LegendItem(color: Colors.orange, label: 'Late'),
            ],
          ),
          const SizedBox(height: 12),
          // ── Days of Week ──
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
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          // ── Grid ──
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

              final dayDate = DateTime(_currentMonth.year, _currentMonth.month, day);
              final now = DateTime.now();
              final isToday = day == now.day &&
                  _currentMonth.month == now.month &&
                  _currentMonth.year == now.year;

              final isSelected = _selectedDay != null &&
                  _selectedDay!.day == day &&
                  _selectedDay!.month == _currentMonth.month &&
                  _selectedDay!.year == _currentMonth.year;

              final key = '${_currentMonth.year}-${_currentMonth.month}-$day';
              final status = recordMap[key];
              final statusColor = _getAttendanceColor(status);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDay = dayDate;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: _buildDayDecoration(
                    isSelected: isSelected,
                    isToday: isToday,
                    status: status,
                    statusColor: statusColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$day',
                        style: _buildDayTextStyle(
                          isSelected: isSelected,
                          isToday: isToday,
                          status: status,
                          statusColor: statusColor,
                        ),
                      ),
                      if (status != null && statusColor != Colors.transparent)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
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

// ── _LegendItem ──────────────────────────────────────────────
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: color, width: 1),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
