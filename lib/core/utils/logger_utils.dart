import 'package:flutter/foundation.dart';

class AppLogger {
  static void logError(String message, {dynamic error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      print(' ERROR: $message ');
      if (error != null) print('Error details: $error');
      if (stackTrace != null) print('Stack trace: $stackTrace');
    }
  }

  static void logInfo(String message) {
    if (kDebugMode) {
      print(' INFO: $message');
    }
  }

  static void logWarning(String message) {
    if (kDebugMode) {
      print(' WARNING: $message');
    }
  }

  static void logSuccess(String message) {
    if (kDebugMode) {
      print(' SUCCESS: $message ');
    }
  }
}