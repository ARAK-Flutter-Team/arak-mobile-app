import 'package:flutter/material.dart';

class AttendanceDayRecord {
  final DateTime date;
  final String status; // Present, Absent, Late, NotRecorded

  const AttendanceDayRecord({
    required this.date,
    required this.status,
  });
}

class StudentAttendance {
  final String name;
  final String grade;
  final String status;
  final String date;
  final String checkIn;
  final String checkOut;
  final double attendanceRate;
  final int lateTimes;
  final int absentTimes;
  final List<AttendanceDayRecord> records; // ✅ جديد

  const StudentAttendance({
    required this.name,
    required this.grade,
    required this.status,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.attendanceRate,
    required this.lateTimes,
    required this.absentTimes,
    this.records = const [], // ✅ جديد
  });
}
