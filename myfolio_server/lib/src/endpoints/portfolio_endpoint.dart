import 'package:myfolio_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Public, read-only access to portfolio content.
///
/// Content is seeded server-side via `bin/seed.dart`; no write operations are
/// exposed over RPC.
class PortfolioEndpoint extends Endpoint {
  Future<List<Roles>> getRoles(Session session) async {
    return await Roles.db.find(
      session,
      orderByList: (t) => [Order(column: t.displayOrder), Order(column: t.id)],
    );
  }

  Future<List<Project>> getProjectList(Session session) async {
    return await Project.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.id,
    );
  }

  Future<List<Skill>> getSkills(Session session) async {
    return await Skill.db.find(
      session,
      orderByList: (t) => [Order(column: t.displayOrder), Order(column: t.id)],
    );
  }

  Future<List<Experience>> getExperiences(Session session) async {
    return await Experience.db.find(
      session,
      orderByList: (t) => [Order(column: t.displayOrder), Order(column: t.id)],
    );
  }

  Future<List<Education>> getEducations(Session session) async {
    return await Education.db.find(
      session,
      orderByList: (t) => [Order(column: t.displayOrder), Order(column: t.id)],
    );
  }
}
