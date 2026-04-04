
import '../../l10n/app_localizations.dart';

extension AppLocalizationsExtension on AppLocalizations {
  String getString(String key) {
    switch (key) {
      case 'tasks':
        return tasks;
      case 'messages':
        return messages;
      case 'attendance':
        return attendance;
      case 'schedule':
        return schedule;
      case 'homeworkAdded':
        return homeworkAdded;
      case 'messageFromAdmin':
        return messageFromAdmin;
      default:
        return key; // fallback
    }
  }
}