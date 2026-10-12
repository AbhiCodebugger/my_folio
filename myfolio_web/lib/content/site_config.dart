/// Presentation copy and site-level settings that are not stored in the
/// database. Edit this file to tune positioning, metrics and project imagery.
library;

/// Base path the site is served under.
///
/// `jaspr build` (release) targets GitHub Pages at `/my_folio/`; `jaspr serve`
/// (debug) serves from the root, so it defaults to `/`. Override either with
/// `--dart-define=BASE_PATH=...`.
const String basePath = String.fromEnvironment(
  'BASE_PATH',
  defaultValue: bool.fromEnvironment('jaspr.flags.release') ? '/my_folio/' : '/',
);

/// Base path used by `jaspr build` for GitHub Pages.
const String productionBasePath = '/my_folio/';

/// Absolute public URL of the site (used for canonical, OG and sitemap URLs).
const String siteUrl = 'https://abhicodebugger.github.io/my_folio/';

/// Resolves a site-relative [relative] path against [basePath].
///
/// `sitePath('images/a.webp', base: '/my_folio/')` → `/my_folio/images/a.webp`.
String sitePath(String relative, {String base = basePath}) {
  final normalizedBase = base.endsWith('/') ? base : '$base/';
  final trimmed = relative.startsWith('/') ? relative.substring(1) : relative;
  return '$normalizedBase$trimmed';
}

/// Absolute URL for a site-relative path, e.g. for Open Graph images.
String absoluteUrl(String relative) {
  final trimmed = relative.startsWith('/') ? relative.substring(1) : relative;
  return '$siteUrl$trimmed';
}

/// One-sentence positioning statement shown in the hero.
const String positioning =
    'I design and ship fast, reliable Flutter apps — from architecture to the '
    'App Store — and the Dart backends that power them.';

/// Short meta description used for search results and link previews.
const String metaDescription =
    'Senior Flutter & mobile engineer with 6+ years building production iOS '
    'and Android apps, scalable architecture and Dart backends. Open to '
    'senior mobile roles.';

/// A quantified highlight shown in the metrics strip.
class Metric {
  const Metric(this.value, this.label);
  final String value;
  final String label;
}

const List<Metric> metrics = [
  Metric('6+', 'years shipping production mobile apps'),
  Metric('1,000+', 'daily active drivers on a logistics app I led'),
  Metric('10K+', 'articles/day ingested by a real-time news platform'),
  Metric('60 fps', 'scroll performance as a non-negotiable'),
];

/// Project imagery, keyed by project title (ported from the former Flutter app).
const Map<String, String> projectImageByTitle = {
  'Market Intelligence Platform': 'images/news.webp',
  'Freight & Logistics Suite': 'images/logistic.webp',
  'HealthVitals Tracker': 'images/health.webp',
  'Social Engagement Platform': 'images/social.webp',
  'E-Commerce Marketplace': 'images/shopping.webp',
};

/// Intrinsic image sizes so the browser can reserve space (no layout shift).
const Map<String, (int, int)> imageSizes = {
  'images/news.webp': (1200, 800),
  'images/logistic.webp': (1200, 900),
  'images/health.webp': (1200, 675),
  'images/social.webp': (1200, 900),
  'images/shopping.webp': (1200, 676),
  'images/profile.webp': (640, 786),
};

/// Site-relative image path for a project, or null when none is known.
String? projectImageFor(String title) => projectImageByTitle[title];

/// Résumé used when the database value is missing or a known stale link.
const String defaultResumeUrl = 'https://drive.google.com/file/d/1cUR-YqYjj90HceYdHSjUVWhdsGyPQhof/view?usp=sharing';

const Set<String> _legacyResumeUrls = {
  'https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=sharing',
  'https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=drive_link',
};

/// Picks the résumé URL: the profile value, then the stored file, then the
/// default — skipping known stale links.
String resolveResumeUrl({String? profileUrl, String? storedFileUrl}) {
  for (final url in [profileUrl, storedFileUrl]) {
    if (url != null && url.isNotEmpty && !_legacyResumeUrls.contains(url)) {
      return url;
    }
  }
  return defaultResumeUrl;
}

/// Copy for the "How this site is built" section.
const String architectureIntro =
    'This site is itself a small production system. Content lives in '
    'PostgreSQL behind a Serverpod (Dart) API. On every push — and once a day — '
    'GitHub Actions wakes the API, pulls the content once, and pre-renders '
    'plain HTML with Jaspr. Visitors get a static page from a CDN and never '
    'wait on a server.';

const List<String> architecturePoints = [
  'Static HTML pre-rendered with Jaspr — crawlable, instant, no runtime API calls.',
  'Serverpod API with a read-only public surface; seeding is an operator-only command.',
  'Neon serverless PostgreSQL with migrations applied on deploy.',
  'CI fails closed: if content can’t be fetched, the last good deploy stays live.',
];
