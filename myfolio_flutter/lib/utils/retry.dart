/// Retries [action] with a fixed delay between attempts.
Future<bool> retryUntilSuccess({
  required Future<bool> Function() action,
  int maxAttempts = 12,
  Duration delay = const Duration(seconds: 5),
  void Function(int attempt)? onRetry,
}) async {
  for (var attempt = 0; attempt < maxAttempts; attempt++) {
    if (attempt > 0) {
      onRetry?.call(attempt);
      await Future.delayed(delay);
    }

    if (await action()) {
      return true;
    }
  }

  return false;
}
