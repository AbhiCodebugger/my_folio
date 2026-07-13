import 'package:flutter_test/flutter_test.dart';
import 'package:myfolio_flutter/utils/retry.dart';

void main() {
  group('retryUntilSuccess', () {
    test('returns true on first successful attempt', () async {
      var attempts = 0;

      final result = await retryUntilSuccess(
        maxAttempts: 3,
        delay: Duration.zero,
        action: () async {
          attempts++;
          return true;
        },
      );

      expect(result, isTrue);
      expect(attempts, 1);
    });

    test('retries until action succeeds', () async {
      var attempts = 0;

      final result = await retryUntilSuccess(
        maxAttempts: 4,
        delay: Duration.zero,
        action: () async {
          attempts++;
          return attempts >= 3;
        },
      );

      expect(result, isTrue);
      expect(attempts, 3);
    });

    test('returns false when all attempts fail', () async {
      var attempts = 0;

      final result = await retryUntilSuccess(
        maxAttempts: 3,
        delay: Duration.zero,
        action: () async {
          attempts++;
          return false;
        },
      );

      expect(result, isFalse);
      expect(attempts, 3);
    });
  });
}
