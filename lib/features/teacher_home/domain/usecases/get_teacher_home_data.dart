import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/teacher_home_entity.dart';
import '../repositories/teacher_home_repository.dart';

class GetTeacherHomeData {
  final TeacherHomeRepository repository;

  GetTeacherHomeData(this.repository);

  Future<Either<Failure, TeacherHomeEntity>> call() {
    return repository.getTeacherHomeData();
  }
}