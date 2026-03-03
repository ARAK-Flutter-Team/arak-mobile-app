import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../network/network_info.dart';
import '../network/network_info_impl.dart' as impl;

final sl = GetIt.instance;

void init() {
  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnectionChecker()),
  );
  // باقي الـ dependencies...
}
