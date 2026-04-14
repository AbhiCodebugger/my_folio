import 'package:serverpod/serverpod.dart';

class FileEndpoint extends Endpoint {
  /// Returns a signed URL for the user's resume.
  /// The file is expected to be uploaded to 'public' storage with path 'resume.pdf'.
  Future<String?> getResumeUrl(Session session) async {
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
  }

  Future<String?> getUploadUrl(Session session, String path) async {
    dynamic description = await session.storage
        .createDirectFileUploadDescription(
          storageId: 'public',
          path: path,
        );
    return description?.url?.toString();
  }
}
