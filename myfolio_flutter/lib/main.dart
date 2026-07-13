import 'package:myfolio_flutter/bootstrap.dart';
import 'package:myfolio_flutter/config/environment.dart';

/// Production entry point (default flavor).
///
/// Build/run:
///   flutter build web --release -t lib/main.dart \
///     --dart-define=API_URL=https://my-folio-a91r.onrender.com
Future<void> main() => bootstrap(Flavor.prod);
