import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/student_attendance_entity.dart';
import '../providers/attendance_provider.dart';

class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Attendance Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          onPressed: () {},
        ),
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
                "Attendance Calendar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              AttendanceCalendar(initialMonth: DateTime(2024, 10, 1)),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Last updated: ${data.checkOut}",
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Widgets (هنا بقى التعديلات بتاعتك) ---

class StudentInfoCard extends StatelessWidget {
  final StudentAttendance data;
  const StudentInfoCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4), // انت زودت ده، تمام
          Text(data.grade,
              style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 10), // وده كمان
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20)),
            child: Text(data.status,
                style: TextStyle(
                    color: Colors.green[700], fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class TimeBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String time;
  final MaterialColor color;
  const TimeBox(
      {required this.icon,
      required this.label,
      required this.time,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color[50], borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: <Widget>[
          Icon(icon, color: color[700]),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              Text(time,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color[900])),
            ],
          ),
        ],
      ),
    );
  }
}

class TimeAttendanceCard extends StatelessWidget {
  final StudentAttendance data;
  const TimeAttendanceCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: TimeBox(
                icon: Icons.login,
                label: "Check In",
                time: data.checkIn,
                color: Colors.green)),
        const SizedBox(width: 15),
        Expanded(
            child: TimeBox(
                icon: Icons.logout,
                label: "Check Out",
                time: data.checkOut,
                color: Colors.red)),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  final String value;
  final String label;
  final double progress;
  final MaterialColor color;
  const StatItem(
      {required this.value,
      required this.label,
      required this.progress,
      required this.color,
      super.key});

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
                backgroundColor: color[50],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color[700])),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class StatsOverviewRow extends StatelessWidget {
  final StudentAttendance data;
  const StatsOverviewRow({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        StatItem(
            value: "${data.attendanceRate}%",
            label: "Attendance",
            progress: data.attendanceRate / 100.0,
            color: Colors.blue),
        StatItem(
            value: data.lateTimes.toString(),
            label: "Late",
            progress: data.lateTimes / 10.0,
            color: Colors.orange),
        StatItem(
            value: data.absentTimes.toString(),
            label: "Absent",
            progress: data.absentTimes / 10.0,
            color: Colors.red),
      ],
    );
  }
}

class AttendanceCalendar extends StatefulWidget {
  final DateTime initialMonth;
  const AttendanceCalendar({required this.initialMonth, super.key});

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 5)
          ]),
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
                      color: Colors.grey[800])),
              Row(
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.keyboard_arrow_left, size: 20),
                      onPressed: () => setState(() => _currentMonth = DateTime(
                          _currentMonth.year, _currentMonth.month - 1, 1))),
                  IconButton(
                      icon: const Icon(Icons.keyboard_arrow_right, size: 20),
                      onPressed: () => setState(() => _currentMonth = DateTime(
                          _currentMonth.year, _currentMonth.month + 1, 1))),
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
                        child: Text(e,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                                fontSize: 12)))))
                .toList(),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, crossAxisSpacing: 8, mainAxisSpacing: 8),
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
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('$day',
                    style: TextStyle(
                        fontSize: 14,
                        color: isToday
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade700,
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal)),
              );
            },
          ),
        ],
      ),
    );
  }
}
