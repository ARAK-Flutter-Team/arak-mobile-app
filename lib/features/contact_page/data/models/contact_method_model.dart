import '../../domain/entities/contact_method.dart';
import 'package:flutter/material.dart';

class ContactMethodModel extends ContactMethod {
  const ContactMethodModel({
    required super.title,
    required super.subtitle,
    required super.actionLabel,
    required super.link,
    required super.type,
  });

  // ده mapper بسيط عشان نرجع الـ Icon المناسب
  IconData get iconData {
    switch (type) {
      case ContactType.phone:
        return Icons.phone_in_talk_rounded;
      case ContactType.email:
        return Icons.email_outlined;
      case ContactType.chat:
        return Icons.smart_toy_outlined;
    }
  }

  // محاكاة الـ JSON
  factory ContactMethodModel.fromMap(Map<String, dynamic> map) {
    return ContactMethodModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      actionLabel: map['actionLabel'] ?? '',
      link: map['link'] ?? '',
      type: ContactType.values.firstWhere((e) => e.name == map['type']),
    );
  }
}
