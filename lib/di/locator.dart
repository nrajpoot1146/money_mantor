// lib/di/locator.dart

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerSingleton<Logger>(Logger());
}
