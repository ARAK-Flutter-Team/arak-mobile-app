import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole { teacher, parent }

final userRoleProvider =
StateProvider<UserRole>((ref) => UserRole.teacher);