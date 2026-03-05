import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/chat_datasource.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/repositories/chat_repository.dart';
import '../notifier/chat_notifier.dart';
import '../state/chat_state.dart';

final chatDatasourceProvider = Provider<ChatDatasource>((ref) {

  return ChatDatasource();
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {

  final datasource = ref.read(chatDatasourceProvider);

  return ChatRepositoryImpl(datasource);
});

final chatNotifierProvider =
StateNotifierProvider<ChatNotifier, ChatState>((ref) {

  final repo = ref.read(chatRepositoryProvider);

  return ChatNotifier(repo);
});