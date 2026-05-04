/*import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/teacher_home_entity.dart';

abstract class TeacherHomeRepository {
  Future<Either<Failure, TeacherHomeEntity>> getTeacherHomeData();
}*/
// lib/features/teacher_home/domain/repositories/teacher_home_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/teacher_home_entity.dart';

abstract class TeacherHomeRepository {
  Future<Either<Failure, TeacherHomeEntity>> getTeacherHomeData();
}