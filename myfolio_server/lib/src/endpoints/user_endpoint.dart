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

  Future<void> createUser(Session session) async {
    try {
      User user = User(
        name: "Abhinav Ranjan",
        imagePath: "",
        title: "Senior Flutter Developer",
        socialUrls: [
          'https://www.linkedin.com/in/abhinav-ranjan-78589aa3/',
          'https://github.com/AbhiCodebugger',
          'https://stackoverflow.com/users/14939199/abhinav',
        ],
        summary:
            "Senior Mobile Engineer with deep expertise in Flutter, architecture, and system design. I focus on building fast, reliable cross‑platform applications and shaping technical direction from idea to delivery. I use AI‑assisted development tools to speed up prototyping, improve code quality, and streamline everyday engineering work. I enjoy helping teams work more effectively and ensuring the product is built on a strong, scalable foundation.",
        phoneNumber: '07009789470',
        email: "ranjansme12@gmail.com",
        location: "Noida, India",
        resumeUrl:
            "https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=sharing",
      );
      User newUser = await User.db.insertRow(session, user);
      session.log('User created with id : ${newUser.id}');
    } on DatabaseException catch (e, st) {
      session.log(
        "Database error while creating user ${e.message}",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    } catch (e, st) {
      session.log(
        "Unexpected error in createUser : $e",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    }
  }
}
