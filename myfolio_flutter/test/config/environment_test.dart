import 'package:flutter_test/flutter_test.dart';
import 'package:myfolio_flutter/config/environment.dart';

void main() {
  group('Environment', () {
    test('initialize sets the active flavor', () {
      Environment.initialize(Flavor.dev);
      expect(Environment.current.isDev, isTrue);
      expect(Environment.current.name, 'dev');

      Environment.initialize(Flavor.prod);
      expect(Environment.current.isProd, isTrue);
      expect(Environment.current.name, 'prod');
    });

    test('dev flavor resolves to the local server', () async {
      Environment.initialize(Flavor.dev);
      // Both the bundled config.json and the dev flavor default point at the
      // local server, so this is deterministic in tests.
      final url = await Environment.current.resolveApiUrl();
      expect(url, 'http://localhost:8080');
    });

    test('prod flavor resolves to the remote server', () async {
      Environment.initialize(Flavor.prod);
      final url = await Environment.current.resolveApiUrl();
      expect(url, 'https://my-folio-a91r.onrender.com');
    });
  });
}
