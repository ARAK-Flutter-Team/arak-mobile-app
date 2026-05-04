import '../../domain/entities/contact_method.dart';

class ContactMethodModel extends ContactMethod {
  const ContactMethodModel({
    required super.title,
    required super.subtitle,
    required super.actionLabel,
    required super.link,
    required super.type,
  });

  // ده mapper بسيط عشان نرجع الـ Icon المناسب
  String get iconPath {
    switch (type) {
      case ContactType.phone:
        return 'assets/icons/contact.svg';
      case ContactType.email:
        return 'assets/icons/message-outline.svg';
      case ContactType.chat:
        return 'assets/icons/chatbot.svg';
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
