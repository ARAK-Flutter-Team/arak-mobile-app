class ScheduleFilters {
  final int? classId;
  final int? teacherId;

  const ScheduleFilters({
    this.classId,
    this.teacherId,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (classId != null) params['classId'] = classId;
    if (teacherId != null) params['teacherId'] = teacherId;
    return params;
  }

  ScheduleFilters copyWith({
    int? classId,
    int? teacherId,
  }) {
    return ScheduleFilters(
      classId: classId ?? this.classId,
      teacherId: teacherId ?? this.teacherId,
    );
  }
}