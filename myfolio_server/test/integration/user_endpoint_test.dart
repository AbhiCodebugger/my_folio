import 'package:myfolio_server/src/seed/portfolio_seed.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given UserEndpoint', (sessionBuilder, endpoints) {
    test('when no user exists then getUser returns null', () async {
      final user = await endpoints.user.getUser(sessionBuilder);
      expect(user, isNull);
    });

    group('when a user has been seeded', () {
      test('then getUser returns the created user', () async {
        await seedPortfolio(sessionBuilder.build());

        final user = await endpoints.user.getUser(sessionBuilder);

        expect(user, isNotNull);
        expect(user!.name, isNotEmpty);
        expect(user.email, contains('@'));
      });

      test('then the public response has no phone number', () async {
        await seedPortfolio(sessionBuilder.build());

        final user = await endpoints.user.getUser(sessionBuilder);

        expect(user!.toJsonForProtocol(), isNot(contains('phoneNumber')));
      });
    });
  });
}
