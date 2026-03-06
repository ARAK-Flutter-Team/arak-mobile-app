class SettingsState {

  final bool messageNotification;
  final bool attendanceAlert;
  final bool darkMode;

  const SettingsState({
    required this.messageNotification,
    required this.attendanceAlert,
    required this.darkMode,
  });

  SettingsState copyWith({
    bool? messageNotification,
    bool? attendanceAlert,
    bool? darkMode,
  }) {

    return SettingsState(
      messageNotification:
      messageNotification ?? this.messageNotification,
      attendanceAlert:
      attendanceAlert ?? this.attendanceAlert,
      darkMode:
      darkMode ?? this.darkMode,
    );
  }
}