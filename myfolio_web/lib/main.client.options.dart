// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/client.dart';

import 'package:myfolio_web/components/client/mobile_nav.dart'
    deferred as _mobile_nav;
import 'package:myfolio_web/components/client/theme_toggle.dart'
    deferred as _theme_toggle;

/// Default [ClientOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.client.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultClientOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ClientOptions get defaultClientOptions => ClientOptions(
  clients: {
    'mobile_nav': ClientLoader(
      (p) => _mobile_nav.MobileNav(),
      loader: _mobile_nav.loadLibrary,
    ),
    'theme_toggle': ClientLoader(
      (p) => _theme_toggle.ThemeToggle(),
      loader: _theme_toggle.loadLibrary,
    ),
  },
);
