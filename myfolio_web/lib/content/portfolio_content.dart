import 'dart:async';

import 'package:myfolio_client/myfolio_client.dart';

import 'site_config.dart';

/// Immutable snapshot of all portfolio content, fetched once at build time.
class PortfolioContent {
  const PortfolioContent({
    required this.profile,
    required this.roles,
    required this.projects,
    required this.skills,
    required this.experiences,
    required this.educations,
    required this.resumeUrl,
  });

  final User profile;
  final List<Roles> roles;
  final List<Project> projects;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Education> educations;
  final String resumeUrl;
}

/// The read operations the build needs. Implemented over the Serverpod
/// client in production and faked in tests.
abstract interface class ContentSource {
  Future<User?> getUser();
  Future<List<Roles>> getRoles();
  Future<List<Project>> getProjects();
  Future<List<Skill>> getSkills();
  Future<List<Experience>> getExperiences();
  Future<List<Education>> getEducations();
  Future<String?> getResumeUrl();
}

class ServerpodContentSource implements ContentSource {
  ServerpodContentSource(String apiUrl)
    : _client = Client(
        apiUrl.endsWith('/') ? apiUrl : '$apiUrl/',
        connectionTimeout: const Duration(seconds: 60),
      );

  final Client _client;

  @override
  Future<User?> getUser() => _client.user.getUser();
  @override
  Future<List<Roles>> getRoles() => _client.portfolio.getRoles();
  @override
  Future<List<Project>> getProjects() => _client.portfolio.getProjectList();
  @override
  Future<List<Skill>> getSkills() => _client.portfolio.getSkills();
  @override
  Future<List<Experience>> getExperiences() => _client.portfolio.getExperiences();
  @override
  Future<List<Education>> getEducations() => _client.portfolio.getEducations();
  @override
  Future<String?> getResumeUrl() => _client.file.getResumeUrl();

  void close() => _client.close();
}

/// Thrown when content cannot be loaded; fails the static build.
class ContentLoadException implements Exception {
  ContentLoadException(this.message, [this.cause]);
  final String message;
  final Object? cause;

  @override
  String toString() => 'ContentLoadException: $message${cause == null ? '' : ' (last error: $cause)'}';
}

/// Fetches all content in parallel, retrying every [retryInterval] until
/// [deadline] elapses so a sleeping API has time to wake up.
///
/// Throws [ContentLoadException] when the deadline passes or the API returns
/// no profile.
Future<PortfolioContent> loadPortfolioContent(
  ContentSource source, {
  Duration retryInterval = const Duration(seconds: 10),
  Duration deadline = const Duration(minutes: 3),
  void Function(String message)? log,
}) async {
  final stopwatch = Stopwatch()..start();
  var attempt = 0;
  Object? lastError;

  while (true) {
    attempt++;
    final remaining = deadline - stopwatch.elapsed;
    if (remaining <= Duration.zero) {
      throw ContentLoadException(
        'Could not fetch content within ${deadline.inSeconds}s '
        '($attempt attempts)',
        lastError,
      );
    }

    try {
      log?.call('Fetching content (attempt $attempt)...');
      return await _fetchOnce(source).timeout(remaining);
    } on ContentLoadException {
      rethrow;
    } catch (e) {
      lastError = e;
      log?.call('Attempt $attempt failed: $e');
    }

    final wait = deadline - stopwatch.elapsed;
    if (wait <= Duration.zero) continue;
    await Future<void>.delayed(wait < retryInterval ? wait : retryInterval);
  }
}

Future<PortfolioContent> _fetchOnce(ContentSource source) async {
  final (user, roles, projects, skills, experiences, educations, storedResume) = await (
    source.getUser(),
    source.getRoles(),
    source.getProjects(),
    source.getSkills(),
    source.getExperiences(),
    source.getEducations(),
    // Optional: the profile's résumé URL is the primary source, so a
    // failing storage lookup must not fail the build.
    source.getResumeUrl().then<String?>((v) => v, onError: (_) => null),
  ).wait;

  if (user == null) {
    throw ContentLoadException(
      'Profile content is missing: the API returned no user. '
      'Seed the database (dart bin/seed.dart) before building.',
    );
  }

  return PortfolioContent(
    profile: user,
    roles: roles,
    projects: projects.where((p) => p.isActive).toList(),
    skills: skills,
    experiences: experiences,
    educations: educations,
    resumeUrl: resolveResumeUrl(
      profileUrl: user.resumeUrl,
      storedFileUrl: storedResume,
    ),
  );
}
