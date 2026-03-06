import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {

  SettingsModel({
    required super.messageNotification,
    required super.attendanceAlerts,
    required super.darkMode,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {

    return SettingsModel(
      messageNotification: json["messageNotification"],
      attendanceAlerts: json["attendanceAlerts"],
      darkMode: json["darkMode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messageNotification": messageNotification,
      "attendanceAlerts": attendanceAlerts,
      "darkMode": darkMode,
    };
  }
}