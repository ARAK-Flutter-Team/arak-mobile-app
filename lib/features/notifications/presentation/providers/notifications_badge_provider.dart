import 'package:flutter_riverpod/flutter_riverpod.dart';

final unreadNotificationsProvider = StateProvider<int>((ref) {
  return 0;
});
