import 'dart:convert';

import 'package:flutter/services.dart';

/// The build flavor the app is running as. Each flavor has its own entry point
/// (`lib/main_dev.dart` for [Flavor.dev], `lib/main.dart` for [Flavor.prod]).
enum Flavor { dev, prod }

/// Holds per-flavor configuration, most importantly the Serverpod API URL.
///
/// Resolution order for the API URL:
///   1. `--dart-define=API_URL=...` (highest priority, used by CI/builds)
///   2. `assets/config.json` (`apiUrl` key) — **dev flavor only**; the bundled
///      file points at localhost and must not override prod's remote default
///   3. the flavor's built-in [_defaultApiUrl]
class Environment {
  const Environment._(this.flavor);

  final Flavor flavor;

  static const Environment _dev = Environment._(Flavor.dev);
  static const Environment _prod = Environment._(Flavor.prod);

  /// The active environment. Set once from an entry point via [initialize].
  static Environment get current => _current;
  static Environment _current = _prod;

  /// Sets the active environment. Called by the flavor entry points before the
  /// app is bootstrapped.
  static void initialize(Flavor flavor) {
    _current = flavor == Flavor.dev ? _dev : _prod;
  }

  bool get isDev => flavor == Flavor.dev;
  bool get isProd => flavor == Flavor.prod;

  String get name => flavor.name;

  String get _defaultApiUrl {
    switch (flavor) {
      case Flavor.dev:
        return 'http://localhost:8080';
      case Flavor.prod:
        return 'https://my-folio-a91r.onrender.com';
    }
  }

  /// Resolves the Serverpod API URL for this environment.
  Future<String> resolveApiUrl() async {
    const apiUrlDefine = String.fromEnvironment('API_URL');
    if (apiUrlDefine.isNotEmpty) {
      return apiUrlDefine;
    }

    // The bundled config.json is a local-dev placeholder (localhost). Only the
    // dev flavor reads it so `flutter run` with main.dart hits the prod server
    // without requiring a local Serverpod instance.
    if (isDev) {
      try {
        final configString = await rootBundle.loadString('assets/config.json');
        final config = jsonDecode(configString) as Map<String, dynamic>;
        final apiUrl = config['apiUrl'] as String?;
        if (apiUrl != null && apiUrl.isNotEmpty) {
          return apiUrl;
        }
      } catch (_) {
        // No bundled config (or unreadable) - fall back to the flavor default.
      }
    }

    return _defaultApiUrl;
  }
}
