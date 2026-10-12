import 'package:myfolio_server/src/generated/endpoints.dart';
import 'package:myfolio_server/src/generated/protocol.dart';
import 'package:myfolio_server/src/seed/portfolio_seed.dart';
import 'package:serverpod/serverpod.dart';

/// Seeds portfolio content into the database for the given run mode.
///
/// Operator-only; never exposed over RPC. Safe to run repeatedly — tables that
/// already have rows are left untouched.
///
///   dart bin/seed.dart --mode development
///   dart bin/seed.dart --mode production
///
/// Stop any locally running server first, since this briefly binds the same
/// ports.
Future<void> main(List<String> args) async {
  final pod = Serverpod(args, Protocol(), Endpoints());
  await pod.start();

  final session = await pod.createSession();
  try {
    await seedPortfolio(session);
  } finally {
    await session.close();
    await pod.shutdown(exitProcess: true);
  }
}
