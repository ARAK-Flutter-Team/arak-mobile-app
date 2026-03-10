import '../../domain/entities/contact_method.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/repositories/contact_repository.dart';
import '../datasources/contact_local_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource localDataSource;

  ContactRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ContactMethod>> getContactMethods() async {
    return localDataSource.getContactMethods();
  }

  @override
  Future<List<SocialLink>> getSocialLinks() async {
    return localDataSource.getSocialLinks();
  }
}
