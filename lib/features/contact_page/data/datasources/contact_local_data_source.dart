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
        title: "Call Teacher",
        subtitle: "+20 1XXXXXXXX",
        actionLabel: "Call Now",
        link: "tel:+20123456789",
        type: ContactType.phone, // الآن هيبقى عارف الـ ContactType
      ),
      ContactMethodModel(
        title: "Email Support",
        subtitle: "nursery.support@email",
        actionLabel: "Send Message",
        link: "mailto:nursery.support@email",
        type: ContactType.email,
      ),
      ContactMethodModel(
        title: "Chat with Fox",
        subtitle: "our ai boot",
        actionLabel: "chat",
        link: "https://your-chat-link.com",
        type: ContactType.chat,
      ),
    ];
  }

  @override
  List<SocialLinkModel> getSocialLinks() {
    return const [
      SocialLinkModel(platformName: "Location", url: "https://maps.google.com"),
      SocialLinkModel(platformName: "WeChat", url: "https://wechat.com"),
      SocialLinkModel(platformName: "Facebook", url: "https://facebook.com"),
      SocialLinkModel(platformName: "Instagram", url: "https://instagram.com"),
    ];
  }
}
