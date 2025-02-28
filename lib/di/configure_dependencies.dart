// lib/di/configure_dependencies.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './configure_dependencies.config.dart'; // This will be generated

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async => init(locator);