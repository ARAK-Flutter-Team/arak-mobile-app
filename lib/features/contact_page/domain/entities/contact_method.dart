enum ContactType { phone, email, chat }

class ContactMethod {
  final String title;
  final String subtitle;
  final String actionLabel;
  final String link;
  final ContactType type;

  const ContactMethod({
    required this.title,
    required this.subtitle,
    required this.actionLabel,
    required this.link,
    required this.type,
  });
}
