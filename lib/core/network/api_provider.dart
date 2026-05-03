import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_client.dart';
import '../config/app_config.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(AppConfig.baseUrl);
});