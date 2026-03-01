import '../../domain/entities/teacher_home_entity.dart';

class TeacherHomeState {
  final bool isLoading;
  final String? error;
  final TeacherHomeEntity? data;

  TeacherHomeState({
    this.isLoading = false,
    this.error,
    this.data,
  });

  TeacherHomeState copyWith({
    bool? isLoading,
    String? error,
    TeacherHomeEntity? data,
  }) {
    return TeacherHomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      data: data ?? this.data,
    );
  }
}