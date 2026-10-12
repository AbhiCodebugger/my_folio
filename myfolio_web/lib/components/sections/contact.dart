import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../content/portfolio_content.dart';
import '../icons.dart';
import 'common.dart';
import 'hero.dart';

class ContactSection extends StatelessComponent {
  const ContactSection(this.content, {super.key});
  final PortfolioContent content;

  @override
  Component build(BuildContext context) {
    final profile = content.profile;
    return section(
      id: 'contact',
      classes: 'section',
      attributes: {'aria-labelledby': 'contact-title'},
      [
        div(classes: 'container reveal', [
          div(classes: 'contact-card', [
            span(classes: 'eyebrow', [t('Contact')]),
            h2(id: 'contact-title', classes: 'section-title', [t('Let’s build something great')]),
            p(classes: 'section-lead', [
              t(
                'Hiring for a senior mobile or Flutter role? I’d love to hear about '
                'the team and the problems you’re solving.',
              ),
            ]),
            a(href: 'mailto:${profile.email}', classes: 'contact-email', [t(profile.email)]),
            div(classes: 'hero-ctas', [
              a(href: 'mailto:${profile.email}', classes: 'btn btn-primary', [RawText(iconMail), t('Email me')]),
              a(
                href: content.resumeUrl,
                target: Target.blank,
                classes: 'btn btn-secondary',
                attributes: {'rel': 'noopener noreferrer'},
                [RawText(iconDownload), t('Download résumé')],
              ),
            ]),
            SocialLinks(profile.socialUrls),
          ]),
        ]),
      ],
    );
  }
}
