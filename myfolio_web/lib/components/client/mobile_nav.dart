import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Primary navigation. On narrow screens the links collapse behind a menu
/// button; on wider screens the button is hidden by CSS and links show inline.
@client
class MobileNav extends StatefulComponent {
  const MobileNav({super.key});

  /// Section anchors in page order.
  static const items = [
    ('projects', 'Projects'),
    ('experience', 'Experience'),
    ('skills', 'Skills'),
    ('education', 'Education'),
    ('architecture', 'This site'),
    ('contact', 'Contact'),
  ];

  @override
  State<MobileNav> createState() => _MobileNavState();
}

class _MobileNavState extends State<MobileNav> {
  bool _open = false;

  static const _menuIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true" focusable="false"><path d="M4 6h16M4 12h16M4 18h16"/></svg>';
  static const _closeIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true" focusable="false"><path d="M18 6 6 18M6 6l12 12"/></svg>';

  @override
  Component build(BuildContext context) {
    return nav(
      classes: _open ? 'site-nav open' : 'site-nav',
      attributes: {'aria-label': 'Primary'},
      [
        ul(id: 'nav-list', classes: 'nav-list', [
          for (final (id, label) in MobileNav.items)
            li([
              a(
                href: '#$id',
                // A raw listener (unlike onClick) keeps the anchor's default
                // jump-to-section behaviour.
                events: {'click': (_) => setState(() => _open = false)},
                [Component.text(label)],
              ),
            ]),
        ]),
        button(
          classes: 'icon-btn menu-btn',
          attributes: {
            'type': 'button',
            'aria-controls': 'nav-list',
            'aria-expanded': '$_open',
            'aria-label': _open ? 'Close menu' : 'Open menu',
          },
          onClick: () => setState(() => _open = !_open),
          [RawText(_open ? _closeIcon : _menuIcon)],
        ),
      ],
    );
  }
}
