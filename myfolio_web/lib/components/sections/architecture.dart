import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../../content/site_config.dart';
import 'common.dart';

class ArchitectureSection extends StatelessComponent {
  const ArchitectureSection({super.key});

  @override
  Component build(BuildContext context) {
    return pageSection(
      id: 'architecture',
      eyebrow: 'Behind the scenes',
      title: 'How this site is built',
      children: [
        div(classes: 'arch', [
          figure(classes: 'arch-diagram', [
            RawText(_diagram),
            figcaption(classes: 'visually-hidden', [
              t(
                'Data flows from Neon PostgreSQL to the Serverpod API, which '
                'GitHub Actions calls once at build time to pre-render HTML with '
                'Jaspr; the static files are served from GitHub Pages to visitors.',
              ),
            ]),
          ]),
          div([
            p([t(architectureIntro)]),
            ul(classes: 'arch-points', [
              for (final point in architecturePoints) li([t(point)]),
            ]),
          ]),
        ]),
      ],
    );
  }
}

typedef _Node = (String title, String sub, bool accent);

const List<_Node> _nodes = [
  ('Neon PostgreSQL', 'Portfolio content tables', false),
  ('Serverpod API · Render', 'Read-only public endpoints', false),
  ('GitHub Actions + Jaspr', 'Fetch once → pre-render HTML', true),
  ('GitHub Pages CDN', 'Static HTML, CSS, images', false),
  ('You', 'Instant page · zero API calls', false),
];

const List<String> _edges = ['SQL', 'RPC · build time only', 'deploy', 'HTTPS'];

final String _diagram = () {
  const width = 360, nodeW = 320, nodeH = 58, gap = 38, x = 20, top = 10;
  final b = StringBuffer(
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 $width '
    '${top * 2 + _nodes.length * nodeH + (_nodes.length - 1) * gap}" '
    'role="img" aria-labelledby="arch-svg-title">'
    '<title id="arch-svg-title">Architecture: PostgreSQL to Serverpod to '
    'Jaspr build to GitHub Pages to visitor</title>',
  );
  for (var i = 0; i < _nodes.length; i++) {
    final (title, sub, accent) = _nodes[i];
    final y = top + i * (nodeH + gap);
    b
      ..write(
        '<rect class="${accent ? 'node-accent' : 'node'}" x="$x" y="$y" '
        'width="$nodeW" height="$nodeH" rx="12"/>',
      )
      ..write('<text class="label" x="${width / 2}" y="${y + 25}" text-anchor="middle">${_esc(title)}</text>')
      ..write('<text class="sub" x="${width / 2}" y="${y + 44}" text-anchor="middle">${_esc(sub)}</text>');
    if (i < _edges.length) {
      final y1 = y + nodeH + 4, y2 = y + nodeH + gap - 6;
      b
        ..write('<line class="edge" x1="${width / 2}" y1="$y1" x2="${width / 2}" y2="$y2"/>')
        ..write('<path class="arrow" d="M${width / 2 - 5} ${y2 - 6} L${width / 2} $y2 L${width / 2 + 5} ${y2 - 6} Z"/>')
        ..write('<text class="edge-label" x="${width / 2 + 12}" y="${y1 + gap / 2 + 2}">${_esc(_edges[i])}</text>');
    }
  }
  b.write('</svg>');
  return b.toString();
}();

String _esc(String s) => s.replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;');
