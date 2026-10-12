import 'package:myfolio_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class UserEndpoint extends Endpoint {
  // Fetch user overview details
  Future<User?> getUser(Session session) async {
    final user = await User.db.find(
      session,
      limit: 1,
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
    );
    return user.isNotEmpty ? user.first : null;
  }
}
