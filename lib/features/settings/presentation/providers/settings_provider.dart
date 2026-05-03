import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/settings_controller.dart';
import '../state/settings_state.dart';
import '../../../../shared/providers/current_user_provider.dart';

final settingsProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  ref.watch(currentUserProvider);
  return SettingsController(ref);
});