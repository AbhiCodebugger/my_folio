import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

/// Flips the `data-theme` attribute on `<html>` and remembers the choice.
///
/// The initial theme is applied before first paint by an inline script in
/// `<head>`, so this component only handles clicks.
@client
class ThemeToggle extends StatelessComponent {
  const ThemeToggle({super.key});

  static const _moon =
      '<svg class="icon-moon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/></svg>';
  static const _sun =
      '<svg class="icon-sun" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false"><circle cx="12" cy="12" r="4"/><path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41"/></svg>';

  void _toggle() {
    final root = web.document.documentElement;
    if (root == null) return;
    final current =
        root.getAttribute('data-theme') ??
        (web.window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
    final next = current == 'dark' ? 'light' : 'dark';
    root.setAttribute('data-theme', next);
    try {
      web.window.localStorage.setItem('theme', next);
    } catch (_) {
      // Storage can be unavailable (private mode); the toggle still works.
    }
  }

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'icon-btn theme-toggle',
      attributes: {'type': 'button', 'aria-label': 'Toggle dark mode', 'title': 'Toggle dark mode'},
      onClick: _toggle,
      [RawText(_moon), RawText(_sun)],
    );
  }
}
