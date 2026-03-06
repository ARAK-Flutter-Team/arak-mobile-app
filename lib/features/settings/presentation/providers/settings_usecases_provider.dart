import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_settings.dart';

import '../../data/repositories/settings_repository_impl.dart';
import '../../data/datasources/settings_remote_data_source.dart';



/// Data Source
final settingsRemoteDataSourceProvider =
Provider<SettingsRemoteDataSource>((ref) {
  return SettingsRemoteDataSourceImpl();
});


/// Repository
final settingsRepositoryProvider =
Provider<SettingsRepositoryImpl>((ref) {

  final remote = ref.watch(settingsRemoteDataSourceProvider);

  return SettingsRepositoryImpl(remote);
});



/// Get Settings UseCase
final getSettingsProvider =
Provider<GetSettings>((ref) {

  final repository = ref.watch(settingsRepositoryProvider);

  return GetSettings(repository);
});



/// Update Settings UseCase
final updateSettingsProvider =
Provider<UpdateSettings>((ref) {

  final repository = ref.watch(settingsRepositoryProvider);

  return UpdateSettings(repository);
});