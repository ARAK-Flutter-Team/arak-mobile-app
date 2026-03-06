import '../models/settings_model.dart';
import '../models/settings_model.dart';

abstract class SettingsRemoteDataSource {

  Future<SettingsModel> getSettings();

  Future<void> updateSettings(SettingsModel settings);

}
class SettingsRemoteDataSourceImpl
    implements SettingsRemoteDataSource {

  @override
  Future<SettingsModel> getSettings() async {

    /// مؤقت لحد ما يتربط بالـ API
    return SettingsModel(
      messageNotification: true,
      attendanceAlerts: true,
      darkMode: false,
    );
  }

  @override
  Future<void> updateSettings(SettingsModel settings) async {

    /// هنا هيكون API call بعدين
    return;
  }
}