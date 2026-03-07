import 'package:flutter/material.dart';
import '../models/student_attendance_model.dart';
import '../../domain/entities/student_attendance_entity.dart';

abstract class AttendanceRemoteDataSource {
  Future<StudentAttendanceModel> getAttendance();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  @override
  Future<StudentAttendanceModel> getAttendance() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // الداتا الوهمية اللي كانت عندك في الكود
    return const StudentAttendanceModel(
      name: "Ahmed Abdullah Khaled",
      grade: "Grade 9 - Class 3",
      status: "Present Today",
      date: "October 2024",
      checkIn: "08:00 AM",
      checkOut: "02:00 PM",
      attendanceRate: 90.0,
      lateTimes: 3,
      absentTimes: 5,
    );
  }
}
