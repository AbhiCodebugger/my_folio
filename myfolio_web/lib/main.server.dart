/// The entrypoint for the **server** environment.
///
/// During `jaspr build` (static mode) this runs once: it fetches all portfolio
/// content from the Serverpod API, then pre-renders the page to HTML.
library;

import 'dart:io';

import 'package:jaspr/server.dart';

import 'components/portfolio_page.dart';
import 'components/seo_head.dart';
import 'content/portfolio_content.dart';
import 'content/site_config.dart';
// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

/// Portfolio API used to fetch content at build time.
const String apiUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'https://my-folio-a91r.onrender.com',
);

Future<void> main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  final source = ServerpodContentSource(apiUrl);
  final PortfolioContent content;
  try {
    content = await loadPortfolioContent(
      source,
      log: (m) => print('[content] $m'),
    );
  } on ContentLoadException catch (e) {
    stderr.writeln('[content] FAILED: $e');
    // Fail the build so the previously published site stays live.
    exit(1);
  } finally {
    source.close();
  }
  print(
    '[content] Loaded ${content.projects.length} projects, '
    '${content.experiences.length} experiences from $apiUrl',
  );

  runApp(
    Document(
      title: pageTitle(content),
      lang: 'en',
      base: basePath,
      head: seoHead(content),
      body: PortfolioPage(content),
    ),
  );
}
