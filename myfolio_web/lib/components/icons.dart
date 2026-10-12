/// Inline SVG icons (Lucide-style strokes). Rendered as raw markup so they
/// inherit `currentColor` and need no extra requests.
library;

String _icon(String body) =>
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" '
    'stroke="currentColor" stroke-width="2" stroke-linecap="round" '
    'stroke-linejoin="round" aria-hidden="true" focusable="false">$body</svg>';

final String iconDownload = _icon(
  '<path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>'
  '<polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/>',
);

final String iconMail = _icon(
  '<rect x="2" y="4" width="20" height="16" rx="2"/>'
  '<path d="m22 7-10 6L2 7"/>',
);

final String iconMapPin = _icon(
  '<path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z"/>'
  '<circle cx="12" cy="10" r="3"/>',
);

final String iconArrowUpRight = _icon(
  '<path d="M7 17 17 7"/><path d="M7 7h10v10"/>',
);

final String iconLinkedIn = _icon(
  '<path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-4 0v7h-4v-7a6 6 0 0 1 6-6z"/>'
  '<rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/>',
);

final String iconGitHub = _icon(
  '<path d="M15 22v-4a4.8 4.8 0 0 0-1-3.5c3 0 6-2 6-5.5.08-1.25-.27-2.48-1-3.5'
  '.28-1.15.28-2.35 0-3.5 0 0-1 0-3 1.5-2.64-.5-5.36-.5-8 0C6 2 5 2 5 2'
  'c-.3 1.15-.3 2.35 0 3.5A5.403 5.403 0 0 0 4 9c0 3.5 3 5.5 6 5.5'
  '-.39.49-.68 1.05-.85 1.65-.17.6-.22 1.23-.15 1.85v4"/><path d="M9 18c-4.51 2-5-2-7-2"/>',
);

final String iconStack = _icon(
  '<path d="M4 15v5h16v-5"/><path d="M8 16h8"/><path d="m8.5 12.5 7.6 1.6"/>'
  '<path d="m9.9 8.6 7 3.6"/><path d="m12.4 5 5.6 6"/>',
);

final String iconLink = _icon(
  '<path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/>'
  '<path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/>',
);

/// A labelled social profile derived from its URL.
class SocialProfile {
  const SocialProfile(this.label, this.url, this.icon);
  final String label;
  final String url;
  final String icon;
}

SocialProfile socialProfileFor(String url) {
  final host = Uri.tryParse(url)?.host.toLowerCase() ?? '';
  if (host.contains('linkedin')) return SocialProfile('LinkedIn', url, iconLinkedIn);
  if (host.contains('github')) return SocialProfile('GitHub', url, iconGitHub);
  if (host.contains('stackoverflow')) {
    return SocialProfile('Stack Overflow', url, iconStack);
  }
  return SocialProfile(host.isEmpty ? url : host.replaceFirst('www.', ''), url, iconLink);
}
