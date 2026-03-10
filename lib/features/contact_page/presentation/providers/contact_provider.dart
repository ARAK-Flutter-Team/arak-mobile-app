import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/contact_local_data_source.dart';
import '../../data/repositories/contact_repository_impl.dart';
import '../../domain/entities/contact_method.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/repositories/contact_repository.dart';

// DataSource Provider
final contactLocalDataSourceProvider = Provider<ContactLocalDataSource>((ref) {
  return ContactLocalDataSourceImpl();
});

// Repository Provider
final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  return ContactRepositoryImpl(
      localDataSource: ref.watch(contactLocalDataSourceProvider));
});

// State Notifier for Contact Methods
final contactMethodsProvider = FutureProvider<List<ContactMethod>>((ref) async {
  return ref.watch(contactRepositoryProvider).getContactMethods();
});

// State Notifier for Social Links
final socialLinksProvider = FutureProvider<List<SocialLink>>((ref) async {
  return ref.watch(contactRepositoryProvider).getSocialLinks();
});
