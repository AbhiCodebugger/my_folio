import 'package:myfolio_web/content/site_config.dart';
import 'package:test/test.dart';

void main() {
  group('sitePath', () {
    test('prefixes the production base path', () {
      expect(
        sitePath('images/a.webp', base: productionBasePath),
        '/my_folio/images/a.webp',
      );
    });

    test('defaults to the root outside release builds (jaspr serve)', () {
      // Tests run without -Djaspr.flags.release, like `jaspr serve`.
      expect(basePath, '/');
      expect(sitePath('images/a.webp'), '/images/a.webp');
    });

    test('tolerates a leading slash and a base without trailing slash', () {
      expect(sitePath('/images/a.webp', base: '/x'), '/x/images/a.webp');
    });

    test('works at the root base path', () {
      expect(sitePath('robots.txt', base: '/'), '/robots.txt');
    });
  });

  group('resolveResumeUrl', () {
    test('prefers the profile URL', () {
      expect(resolveResumeUrl(profileUrl: 'https://a', storedFileUrl: 'https://b'), 'https://a');
    });

    test('skips legacy links and empty values', () {
      expect(
        resolveResumeUrl(
          profileUrl: 'https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=sharing',
          storedFileUrl: '',
        ),
        defaultResumeUrl,
      );
    });

    test('falls back to the stored file URL', () {
      expect(resolveResumeUrl(profileUrl: null, storedFileUrl: 'https://b'), 'https://b');
    });
  });
}
