class ScheduleFilters {
  final int? classId;

  const ScheduleFilters({
    this.classId,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (classId != null) params['classId'] = classId;
    return params;
  }

  ScheduleFilters copyWith({
    int? classId,
  }) {
    return ScheduleFilters(
      classId: classId ?? this.classId,
    );
  }
}