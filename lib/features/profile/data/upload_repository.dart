import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';

class UploadRepository {
  final Dio _dio;
  UploadRepository(this._dio);

  Future<String> uploadPhoto(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
    });

// ✅ الصح — حط /api صريح
    final response = await _dio.post(
      '/api/Upload/photo',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode == 200) {
      final relativeUrl = response.data['url'] as String;
      final serverRoot = _dio.options.baseUrl.endsWith('/api')
          ? _dio.options.baseUrl.substring(0, _dio.options.baseUrl.length - 4)
          : _dio.options.baseUrl;
      return '$serverRoot$relativeUrl';
    }

    throw Exception('Upload failed: ${response.statusCode}');
  }
}

final uploadRepositoryProvider = Provider<UploadRepository>((ref) {
  return UploadRepository(ref.read(dioProvider));
});
