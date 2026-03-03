import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String name;
  final String? avatarUrl;

  const Student({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
