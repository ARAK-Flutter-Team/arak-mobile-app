import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_remote_data_source_impl.dart';
import '../../../../core/network/dio_provider.dart';

final taskRemoteDataSourceProvider =
Provider((ref) => TaskRemoteDataSourceImpl(ref.watch(dioProvider)));