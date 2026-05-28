class Student {
  final String id; // UUID
  final String name;
  final String grade;
  final String status;
  final String date;
  final String checkIn;
  final String checkOut;
  final double attendanceRate;
  // 🚀 INTEGRATION: Add nullable parent connection fields
  final String? parentName;
  final String? parentUserId;

  const Student({
    required this.id,
    required this.name,
    required this.grade,
    required this.status,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.attendanceRate,
    this.parentName,
    this.parentUserId,
  });
}
