import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/settings_controller.dart';
import '../state/settings_state.dart';

final settingsControllerProvider =
StateNotifierProvider<SettingsController, SettingsState>((ref) {
  return SettingsController();
});