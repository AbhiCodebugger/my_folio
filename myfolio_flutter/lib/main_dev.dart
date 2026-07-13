import 'package:myfolio_flutter/bootstrap.dart';
import 'package:myfolio_flutter/config/environment.dart';

/// Development entry point.
///
/// Connects to the local Serverpod server (http://localhost:8080) by default.
/// Run with:
///   flutter run -t lib/main_dev.dart
Future<void> main() => bootstrap(Flavor.dev);
