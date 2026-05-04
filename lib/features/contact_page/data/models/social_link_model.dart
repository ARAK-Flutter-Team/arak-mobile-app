import '../../domain/entities/social_link.dart';

class SocialLinkModel extends SocialLink {
  const SocialLinkModel({required super.platformName, required super.url});

  String get iconPath {
    switch (platformName.toLowerCase()) {
      case 'facebook':
        return 'assets/icons/facebook.svg'; // Guessed from available assets
      case 'instagram':
        return 'assets/icons/instagram.svg'; // Guessed from available assets
      case 'whatsapp':
        return 'assets/icons/whatsapp.svg'; // Guessed from available assets
      case 'location':
        return 'assets/icons/mdi_location.svg';
      default:
        return 'assets/icons/contact.svg'; // Fallback to an existing icon
    }
  }
}
