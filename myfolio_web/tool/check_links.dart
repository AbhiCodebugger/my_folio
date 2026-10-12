/// Verifies a static build: every local `href`/`src`/`url()` under the base
/// path resolves to a file, required SEO files exist, and no Flutter web
/// artifacts slipped in.
///
///   dart run tool/check_links.dart [buildDir] [basePath]
library;

import 'dart:io';

void main(List<String> args) {
  final buildDir = args.isNotEmpty ? args[0] : 'build/jaspr';
  final base = args.length > 1 ? args[1] : '/my_folio/';
  final errors = <String>[];

  final index = File('$buildDir/index.html');
  if (!index.existsSync()) {
    stderr.writeln('Missing $buildDir/index.html');
    exit(1);
  }
  final html = index.readAsStringSync();

  for (final required in ['robots.txt', 'sitemap.xml', 'images/og.png', 'favicon.png']) {
    if (!File('$buildDir/$required').existsSync()) errors.add('Missing $required');
  }
  if (File('$buildDir/flutter_bootstrap.js').existsSync()) {
    errors.add('Flutter web artifact flutter_bootstrap.js found in output');
  }
  if (!html.contains('<base href="$base"')) {
    errors.add('index.html does not declare <base href="$base">');
  }

  final refs = <String>{
    for (final m in RegExp(r'''(?:href|src)="([^"]+)"''').allMatches(html)) m.group(1)!,
    for (final m in RegExp(r'''url\("([^"]+)"\)''').allMatches(html)) m.group(1)!,
  };

  var checked = 0;
  for (final ref in refs) {
    if (ref.startsWith('#') ||
        ref.startsWith('http://') ||
        ref.startsWith('https://') ||
        ref.startsWith('mailto:') ||
        ref.startsWith('data:')) {
      continue;
    }
    String relative;
    if (ref.startsWith(base)) {
      relative = ref.substring(base.length);
    } else if (ref.startsWith('/')) {
      if (ref == base || ref == base.substring(0, base.length - 1)) continue;
      errors.add('Absolute path outside base path: $ref');
      continue;
    } else {
      relative = ref; // resolved against <base href>
    }
    relative = relative.split('#').first.split('?').first;
    if (relative.isEmpty) continue;
    checked++;
    if (!File('$buildDir/$relative').existsSync()) {
      errors.add('Broken reference: $ref');
    }
  }

  if (errors.isNotEmpty) {
    errors.forEach(stderr.writeln);
    exit(1);
  }
  stdout.writeln('OK: $checked local references resolve under $base');
}
