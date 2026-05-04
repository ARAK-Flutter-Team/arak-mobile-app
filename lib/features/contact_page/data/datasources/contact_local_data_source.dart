import '../models/contact_method_model.dart';
import '../models/social_link_model.dart';
import '../../domain/entities/contact_method.dart'; // <--- ده السطر اللي كان ناقص

abstract class ContactLocalDataSource {
  List<ContactMethodModel> getContactMethods();
  List<SocialLinkModel> getSocialLinks();
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  @override
  List<ContactMethodModel> getContactMethods() {
    return const [
      ContactMethodModel(
        title: "Call Teacher / School",
        subtitle: "+20 1XXXXXXXXX",
        actionLabel: "Call Now",
        link: "tel:+201000000000",
        type: ContactType.phone,
      ),
      ContactMethodModel(
        title: "Email Support",
        subtitle: "support@email.com",
        actionLabel: "Send Message",
        link: "mailto:support@email.com",
        type: ContactType.email,
      ),
    ];
  }

  @override
  List<SocialLinkModel> getSocialLinks() {
    return const [
      SocialLinkModel(platformName: "Facebook", url: "https://www.facebook.com/"),
      SocialLinkModel(platformName: "Instagram", url: "https://www.instagram.com/"),
      SocialLinkModel(platformName: "WhatsApp", url: "https://www.whatsapp.com/"),
      SocialLinkModel(platformName: "Location", url: "https://maps.google.com"),
    ];
  }
}
