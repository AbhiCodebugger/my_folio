import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_web/content/portfolio_content.dart';
import 'package:myfolio_web/content/site_config.dart';
import 'package:test/test.dart';

class FakeSource implements ContentSource {
  FakeSource({
    this.failuresBeforeSuccess = 0,
    this.user,
    this.alwaysFail = false,
    this.resumeLookupFails = false,
  });

  final bool resumeLookupFails;

  int failuresBeforeSuccess;
  final bool alwaysFail;
  User? user;
  int calls = 0;

  Future<T> _respond<T>(T value) async {
    if (alwaysFail || failuresBeforeSuccess > 0) {
      throw StateError('server asleep');
    }
    return value;
  }

  @override
  Future<User?> getUser() {
    calls++;
    final result = _respond(user);
    // One attempt = one getUser call; consume a failure per attempt.
    if (failuresBeforeSuccess > 0) failuresBeforeSuccess--;
    return result;
  }

  @override
  Future<List<Roles>> getRoles() => _respond([Roles(title: 'r', description: 'd')]);
  @override
  Future<List<Project>> getProjects() => _respond([
    Project(title: 'Live', description: 'd', isActive: true),
    Project(title: 'Hidden', description: 'd', isActive: false),
  ]);
  @override
  Future<List<Skill>> getSkills() => _respond([Skill(name: 'Dart')]);
  @override
  Future<List<Experience>> getExperiences() => _respond([Experience(duration: '2024', company: 'C', position: 'P')]);
  @override
  Future<List<Education>> getEducations() => _respond(
    [Education(duration: '2014', institution: 'I', degree: 'D', fieldOfStudy: '')],
  );
  @override
  Future<String?> getResumeUrl() => resumeLookupFails ? Future.error(StateError('no storage')) : _respond(null);
}

User _user({String resumeUrl = ''}) => User(
  name: 'Abhinav Ranjan',
  title: 'Senior Flutter Developer',
  summary: 's',
  imagePath: '',
  socialUrls: const [],
  email: 'a@b.c',
  location: 'Noida',
  resumeUrl: resumeUrl,
);

void main() {
  const fast = Duration(milliseconds: 5);

  test('loads all content on first success and drops inactive projects', () async {
    final source = FakeSource(user: _user(resumeUrl: 'https://cv'));

    final content = await loadPortfolioContent(source, retryInterval: fast);

    expect(content.profile.name, 'Abhinav Ranjan');
    expect(content.projects.map((p) => p.title), ['Live']);
    expect(content.resumeUrl, 'https://cv');
    expect(source.calls, 1);
  });

  test('recovers when the API is cold for the first attempts', () async {
    final source = FakeSource(user: _user(), failuresBeforeSuccess: 3);

    final content = await loadPortfolioContent(
      source,
      retryInterval: fast,
      deadline: const Duration(seconds: 5),
    );

    expect(content.profile.name, isNotEmpty);
    expect(source.calls, 4);
    expect(content.resumeUrl, defaultResumeUrl);
  });

  test('throws once the deadline passes', () async {
    final source = FakeSource(user: _user(), alwaysFail: true);

    await expectLater(
      loadPortfolioContent(
        source,
        retryInterval: fast,
        deadline: const Duration(milliseconds: 60),
      ),
      throwsA(isA<ContentLoadException>()),
    );
    expect(source.calls, greaterThan(1));
  });

  test('throws without retrying when the profile is missing', () async {
    final source = FakeSource(user: null);

    await expectLater(
      loadPortfolioContent(source, retryInterval: fast),
      throwsA(
        isA<ContentLoadException>().having(
          (e) => e.message,
          'message',
          contains('Profile content is missing'),
        ),
      ),
    );
    expect(source.calls, 1);
  });

  test('a failing résumé lookup falls back instead of failing', () async {
    final source = FakeSource(user: _user(), resumeLookupFails: true);

    final content = await loadPortfolioContent(source, retryInterval: fast);

    expect(content.resumeUrl, defaultResumeUrl);
    expect(source.calls, 1);
  });
}
