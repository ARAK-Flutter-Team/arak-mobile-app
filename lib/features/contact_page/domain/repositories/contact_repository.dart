import '../entities/contact_method.dart';
import '../entities/social_link.dart';

abstract class ContactRepository {
  Future<List<ContactMethod>> getContactMethods();
  Future<List<SocialLink>> getSocialLinks();
}
