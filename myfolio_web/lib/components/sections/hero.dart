import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../content/portfolio_content.dart';
import '../../content/site_config.dart';
import '../icons.dart';
import 'common.dart';

class Hero extends StatelessComponent {
  const Hero(this.content, {super.key});
  final PortfolioContent content;

  @override
  Component build(BuildContext context) {
    final profile = content.profile;
    final (w, h) = imageSizes['images/profile.webp']!;
    return section(
      classes: 'hero',
      attributes: {'aria-labelledby': 'hero-title'},
      [
        div(classes: 'container hero-grid', [
          div([
            h1(id: 'hero-title', [t(profile.name)]),
            p(classes: 'hero-title', [t(profile.title)]),
            p(classes: 'hero-positioning', [t(positioning)]),
            if (profile.summary.isNotEmpty) p(classes: 'hero-summary', [t(profile.summary)]),
            div(classes: 'hero-meta', [
              if (profile.location.isNotEmpty) span([RawText(iconMapPin), t(profile.location)]),
              SocialLinks(profile.socialUrls),
            ]),
            div(classes: 'hero-ctas', [
              a(
                href: content.resumeUrl,
                target: Target.blank,
                classes: 'btn btn-primary',
                attributes: {'rel': 'noopener noreferrer'},
                [RawText(iconDownload), t('Download résumé')],
              ),
              a(href: '#contact', classes: 'btn btn-secondary', [RawText(iconMail), t('Contact me')]),
            ]),
          ]),
          div(classes: 'hero-photo', [
            img(
              src: sitePath('images/profile.webp'),
              alt: 'Portrait of ${profile.name}',
              width: w,
              height: h,
              attributes: {'fetchpriority': 'high', 'decoding': 'async'},
            ),
          ]),
        ]),
      ],
    );
  }
}

class SocialLinks extends StatelessComponent {
  const SocialLinks(this.urls, {super.key});
  final List<String> urls;

  @override
  Component build(BuildContext context) {
    return div(classes: 'social', [
      for (final profile in urls.map(socialProfileFor))
        a(
          href: profile.url,
          target: Target.blank,
          attributes: {'rel': 'noopener noreferrer me'},
          [RawText(profile.icon), t(profile.label)],
        ),
    ]);
  }
}

class MetricsStrip extends StatelessComponent {
  const MetricsStrip({super.key});

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'metrics',
      attributes: {'aria-label': 'Highlights'},
      [
        div(classes: 'container', [
          ul(classes: 'metrics-grid', [
            for (final m in metrics)
              li(classes: 'metric', [
                div(classes: 'metric-value', [t(m.value)]),
                div(classes: 'metric-label', [t(m.label)]),
              ]),
          ]),
        ]),
      ],
    );
  }
}
