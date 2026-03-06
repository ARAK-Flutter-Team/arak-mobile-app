import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_remote_data_source.dart';
import '../models/settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {

  final SettingsRemoteDataSource remote;

  SettingsRepositoryImpl(this.remote);

  @override
  Future<Settings> getSettings() {
    return remote.getSettings();
  }

  @override
  Future<void> updateSettings(Settings settings) {

    final model = SettingsModel(
      messageNotification: settings.messageNotification,
      attendanceAlerts: settings.attendanceAlerts,
      darkMode: settings.darkMode,
    );

    return remote.updateSettings(model);
  }
}