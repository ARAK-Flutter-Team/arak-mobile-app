import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// 🔴 فشل من السيرفر
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

// 🔵 فشل في الاتصال بالإنترنت
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

// 🟡 فشل في تسجيل الدخول (مثلاً بيانات غلط)
class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}