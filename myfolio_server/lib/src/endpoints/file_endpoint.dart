import 'package:serverpod/serverpod.dart';

class FileEndpoint extends Endpoint {
  /// Returns a signed URL for the user's resume.
  /// The file is expected to be uploaded to 'public' storage with path 'resume.pdf'.
  Future<String?> getResumeUrl(Session session) async {
    // Storage may be unconfigured (e.g. production without a 'public' bucket);
    // report "no stored résumé" rather than an internal server error.
    try {
      // 1. Check if the file exists
      // 'public' is the storageId.
      // 'resume.pdf' is the path we are enforcing for now.
      var exists = await session.storage.fileExists(
        storageId: 'public',
        path: 'resume.pdf',
      );

      if (!exists) {
        return null;
      }

      // 2. Create the direct download description (signed URL)
      var url = await session.storage.getPublicUrl(
        storageId: 'public',
        path: 'resume.pdf',
      );

      return url?.toString();
    } catch (e, st) {
      session.log(
        'Resume lookup failed: $e',
        level: LogLevel.warning,
        exception: e,
        stackTrace: st,
      );
      return null;
    }
  }
}
