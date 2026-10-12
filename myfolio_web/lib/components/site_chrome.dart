import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'client/mobile_nav.dart';
import 'client/theme_toggle.dart';
import 'sections/common.dart';

class SiteHeader extends StatelessComponent {
  const SiteHeader({required this.name, super.key});
  final String name;

  @override
  Component build(BuildContext context) {
    final parts = name.split(' ');
    return header(classes: 'site-header', [
      div(classes: 'container', [
        a(
          href: '#top',
          classes: 'brand',
          attributes: {'aria-label': '$name — back to top'},
          [
            t(parts.first),
            if (parts.length > 1) span([t(' ${parts.skip(1).join(' ')}')]),
          ],
        ),
        div(classes: 'header-actions', [
          const MobileNav(),
          const ThemeToggle(),
        ]),
      ]),
    ]);
  }
}

class SiteFooter extends StatelessComponent {
  const SiteFooter({required this.name, super.key});
  final String name;

  @override
  Component build(BuildContext context) {
    return footer(classes: 'site-footer', [
      div(classes: 'container', [
        span([t('© ${DateTime.now().year} $name')]),
        span([
          t('Built with Dart — Jaspr & Serverpod. '),
          a(
            href: 'https://github.com/AbhiCodebugger/my_folio',
            target: Target.blank,
            attributes: {'rel': 'noopener noreferrer'},
            [t('View source')],
          ),
        ]),
      ]),
    ]);
  }
}
