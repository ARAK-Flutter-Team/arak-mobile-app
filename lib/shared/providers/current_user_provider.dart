import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/entities/user.dart';

final currentUserProvider = StateProvider<User?>((ref) => null);