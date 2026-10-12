/// Site stylesheet, inlined into `<head>` so first paint needs no extra
/// request. Colors are CSS custom properties switched by `data-theme` on
/// `<html>`; without JS the OS preference applies.
library;

import '../content/site_config.dart';

String siteCss() =>
    '''
@font-face {
  font-family: "Inter";
  src: url("${sitePath('fonts/inter-var-latin.woff2')}") format("woff2");
  font-weight: 100 900;
  font-style: normal;
  font-display: swap;
}

:root {
  --bg: #f7f8fb;
  --surface: #ffffff;
  --surface-2: #f1f4f9;
  --text: #0f172a;
  --muted: #475569;
  --border: #e2e8f0;
  --accent: #4338ca;
  --accent-contrast: #ffffff;
  --accent-soft: #eef2ff;
  --ring: #6366f1;
  --hero-glow: rgba(99, 102, 241, 0.16);
  --shadow: 0 1px 2px rgba(15, 23, 42, 0.06), 0 8px 24px rgba(15, 23, 42, 0.06);
  --radius: 16px;
  --container: 1120px;
  --header-h: 64px;
  color-scheme: light;
}

:root[data-theme="dark"] {
  --bg: #0b1220;
  --surface: #111a2e;
  --surface-2: #16213a;
  --text: #e7ecf5;
  --muted: #a3afc4;
  --border: #22304d;
  --accent: #a5b4fc;
  --accent-contrast: #0b1220;
  --accent-soft: #1c2650;
  --ring: #a5b4fc;
  --hero-glow: rgba(99, 102, 241, 0.22);
  --shadow: 0 1px 2px rgba(0, 0, 0, 0.3), 0 8px 24px rgba(0, 0, 0, 0.25);
  color-scheme: dark;
}

@media (prefers-color-scheme: dark) {
  :root:not([data-theme]) {
    --bg: #0b1220;
    --surface: #111a2e;
    --surface-2: #16213a;
    --text: #e7ecf5;
    --muted: #a3afc4;
    --border: #22304d;
    --accent: #a5b4fc;
    --accent-contrast: #0b1220;
    --accent-soft: #1c2650;
    --ring: #a5b4fc;
    --hero-glow: rgba(99, 102, 241, 0.22);
    color-scheme: dark;
  }
}

*, *::before, *::after { box-sizing: border-box; }
html { scroll-behavior: smooth; scroll-padding-top: calc(var(--header-h) + 16px); -webkit-text-size-adjust: 100%; }
@media (prefers-reduced-motion: reduce) { html { scroll-behavior: auto; } }
body {
  margin: 0;
  background: var(--bg);
  color: var(--text);
  font-family: "Inter", ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
  font-size: 1.0625rem;
  line-height: 1.65;
  -webkit-font-smoothing: antialiased;
  overflow-x: hidden;
}
img, svg { max-width: 100%; height: auto; display: block; }
a { color: var(--accent); text-underline-offset: 3px; }
h1, h2, h3 { line-height: 1.2; letter-spacing: -0.02em; margin: 0; }
p { margin: 0; }
ul, ol { margin: 0; padding: 0; list-style: none; }
:focus-visible { outline: 3px solid var(--ring); outline-offset: 3px; border-radius: 6px; }

.visually-hidden {
  position: absolute !important; width: 1px; height: 1px; padding: 0; margin: -1px;
  overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; border: 0;
}
.skip-link {
  position: absolute; left: 16px; top: -48px; z-index: 100;
  background: var(--accent); color: var(--accent-contrast);
  padding: 8px 14px; border-radius: 8px; font-weight: 600; text-decoration: none;
}
.skip-link:focus { top: 12px; }

.container { width: 100%; max-width: var(--container); margin: 0 auto; padding: 0 20px; }
.section { padding: 88px 0; }
.section-alt { background: var(--surface-2); }
.eyebrow {
  display: inline-block; font-size: 0.8rem; font-weight: 700; letter-spacing: 0.14em;
  text-transform: uppercase; color: var(--accent); margin-bottom: 10px;
}
.section-title { font-size: clamp(1.75rem, 3.2vw, 2.4rem); font-weight: 800; }
.section-lead { color: var(--muted); max-width: 680px; margin-top: 12px; }
.section-head { margin-bottom: 40px; }

/* Header */
.site-header {
  position: sticky; top: 0; z-index: 50; height: var(--header-h);
  background: color-mix(in srgb, var(--bg) 82%, transparent);
  backdrop-filter: saturate(180%) blur(12px);
  -webkit-backdrop-filter: saturate(180%) blur(12px);
  border-bottom: 1px solid var(--border);
}
.site-header .container { display: flex; align-items: center; justify-content: space-between; height: 100%; gap: 16px; }
.brand { font-weight: 800; color: var(--text); text-decoration: none; letter-spacing: -0.02em; font-size: 1.1rem; }
.brand span { color: var(--accent); }
.header-actions, .site-nav { display: flex; align-items: center; gap: 8px; }
.nav-list { display: flex; gap: 4px; }
.nav-list a {
  color: var(--muted); text-decoration: none; font-size: 0.95rem; font-weight: 500;
  padding: 8px 12px; border-radius: 8px;
}
.nav-list a:hover { color: var(--text); background: var(--surface-2); }
.icon-btn {
  display: inline-flex; align-items: center; justify-content: center;
  width: 40px; height: 40px; border-radius: 10px; cursor: pointer;
  border: 1px solid var(--border); background: var(--surface); color: var(--text);
}
.icon-btn:hover { background: var(--surface-2); }
.icon-btn svg { width: 20px; height: 20px; }
.theme-toggle .icon-sun { display: none; }
:root[data-theme="dark"] .theme-toggle .icon-sun { display: block; }
:root[data-theme="dark"] .theme-toggle .icon-moon { display: none; }
.menu-btn { display: none; }

@media (max-width: 599px) {
  .menu-btn { display: inline-flex; }
  .nav-list {
    display: none; position: absolute; top: var(--header-h); left: 0; right: 0;
    flex-direction: column; gap: 0; padding: 8px 20px 16px;
    background: var(--bg); border-bottom: 1px solid var(--border); box-shadow: var(--shadow);
  }
  .site-nav.open .nav-list { display: flex; }
  .nav-list a { display: block; padding: 12px 8px; font-size: 1rem; }
}
@media (min-width: 600px) and (max-width: 1023px) {
  .nav-list a { padding: 8px; font-size: 0.9rem; }
}

/* Buttons */
.btn {
  display: inline-flex; align-items: center; gap: 8px; justify-content: center;
  padding: 12px 20px; border-radius: 12px; font-weight: 600; font-size: 1rem;
  text-decoration: none; border: 1px solid transparent; transition: transform .15s ease, box-shadow .15s ease;
}
.btn svg { width: 18px; height: 18px; }
.btn-primary { background: var(--accent); color: var(--accent-contrast); box-shadow: var(--shadow); }
.btn-primary:hover { transform: translateY(-1px); }
.btn-secondary { background: var(--surface); color: var(--text); border-color: var(--border); }
.btn-secondary:hover { background: var(--surface-2); }

/* Hero */
.hero { position: relative; padding: 72px 0 56px; overflow: hidden; }
.hero::before {
  content: ""; position: absolute; inset: -20% -10% auto auto; width: 720px; height: 720px;
  background: radial-gradient(closest-side, var(--hero-glow), transparent); pointer-events: none;
}
.hero-grid { position: relative; display: grid; gap: 40px; align-items: center; }
.hero h1 { font-size: clamp(2.4rem, 6vw, 4rem); font-weight: 800; }
.hero-title { font-size: clamp(1.15rem, 2.2vw, 1.4rem); font-weight: 600; color: var(--accent); margin-top: 8px; }
.hero-positioning { font-size: clamp(1.15rem, 2vw, 1.35rem); margin-top: 20px; max-width: 620px; }
.hero-summary { color: var(--muted); margin-top: 14px; max-width: 620px; }
.hero-meta { display: flex; flex-wrap: wrap; align-items: center; gap: 8px 18px; margin-top: 18px; color: var(--muted); font-size: 0.95rem; }
.hero-meta svg { width: 18px; height: 18px; display: inline-block; vertical-align: -3px; margin-right: 6px; }
.hero-ctas { display: flex; flex-wrap: wrap; gap: 12px; margin-top: 28px; }
.social { display: flex; flex-wrap: wrap; gap: 8px 16px; }
.social a { color: var(--muted); font-weight: 500; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; }
.social a:hover { color: var(--text); text-decoration: underline; }
.social svg { width: 18px; height: 18px; }
.hero-photo {
  justify-self: center; width: min(320px, 70vw); aspect-ratio: 1; border-radius: 50%; padding: 6px;
  background: linear-gradient(135deg, var(--accent), #0ea5e9);
}
.hero-photo img { width: 100%; height: 100%; object-fit: cover; object-position: 50% 22%; border-radius: 50%; border: 4px solid var(--bg); }
@media (min-width: 1024px) {
  .hero { padding: 96px 0 72px; }
  .hero-grid { grid-template-columns: 1.5fr 1fr; }
}
@media (max-width: 1023px) { .hero-photo { order: -1; width: min(220px, 56vw); } }

/* Metrics */
.metrics { padding: 0 0 56px; }
.metrics-grid {
  display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 1px;
  background: var(--border); border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden;
}
.metric { background: var(--surface); padding: 22px 20px; }
.metric-value { font-size: clamp(1.6rem, 3vw, 2.2rem); font-weight: 800; letter-spacing: -0.03em; }
.metric-label { color: var(--muted); font-size: 0.92rem; line-height: 1.45; margin-top: 4px; }
@media (min-width: 1024px) { .metrics-grid { grid-template-columns: repeat(4, minmax(0, 1fr)); } }

/* Projects */
.projects { display: grid; gap: 28px; }
.case {
  display: grid; background: var(--surface); border: 1px solid var(--border);
  border-radius: var(--radius); overflow: hidden; box-shadow: var(--shadow);
}
.case-media { background: var(--surface-2); aspect-ratio: 16 / 10; overflow: hidden; }
.case-media img { width: 100%; height: 100%; object-fit: cover; }
.case-body { padding: 24px; display: flex; flex-direction: column; gap: 14px; }
.case-index { font-size: 0.8rem; font-weight: 700; color: var(--accent); letter-spacing: 0.12em; }
.case h3 { font-size: 1.4rem; font-weight: 700; }
.case p { color: var(--muted); }
.chips { display: flex; flex-wrap: wrap; gap: 8px; }
.chip {
  font-size: 0.82rem; font-weight: 600; padding: 4px 10px; border-radius: 999px;
  background: var(--accent-soft); color: var(--accent);
}
.case-link { font-weight: 600; align-self: flex-start; }
@media (min-width: 1024px) {
  .case { grid-template-columns: 1fr 1.1fr; }
  .case-media { aspect-ratio: auto; min-height: 100%; }
  .case:nth-child(even) .case-media { order: 2; }
  .case-body { padding: 36px; }
}

/* Experience timeline */
.timeline { position: relative; display: grid; gap: 20px; padding-left: 28px; }
.timeline::before { content: ""; position: absolute; left: 7px; top: 8px; bottom: 8px; width: 2px; background: var(--border); }
.timeline-item { position: relative; background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 20px 22px; }
.timeline-item::before {
  content: ""; position: absolute; left: -28px; top: 26px; width: 16px; height: 16px; border-radius: 50%;
  background: var(--bg); border: 3px solid var(--accent);
}
.timeline-item:first-child::before { background: var(--accent); }
.timeline-item h3 { font-size: 1.15rem; font-weight: 700; }
.timeline-company { font-weight: 600; color: var(--text); }
.timeline-duration { color: var(--muted); font-size: 0.92rem; }
@media (min-width: 600px) {
  .timeline-row { display: flex; justify-content: space-between; gap: 16px; align-items: baseline; }
}

/* Skills & expertise */
.roles { display: grid; gap: 16px; margin-bottom: 36px; }
.role { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 22px; }
.role h3 { font-size: 1.1rem; font-weight: 700; margin-bottom: 8px; }
.role p { color: var(--muted); font-size: 0.96rem; }
@media (min-width: 600px) { .roles { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
.skill-list { display: flex; flex-wrap: wrap; gap: 10px; }
.skill-list li {
  padding: 8px 14px; border-radius: 10px; background: var(--surface); border: 1px solid var(--border);
  font-weight: 600; font-size: 0.95rem;
}

/* Education */
.edu-list { display: grid; gap: 16px; }
.edu { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 20px 22px; }
.edu h3 { font-size: 1.1rem; font-weight: 700; }
.edu-institution { color: var(--text); font-weight: 500; }
.edu-duration { color: var(--muted); font-size: 0.92rem; }
@media (min-width: 600px) { .edu-list { grid-template-columns: repeat(3, minmax(0, 1fr)); } }

/* Architecture */
.arch { display: grid; gap: 32px; align-items: center; }
.arch-diagram { margin: 0; background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 20px; color: var(--text); }
.arch-diagram .node { fill: var(--surface-2); stroke: var(--border); stroke-width: 1.5; }
.arch-diagram .node-accent { fill: var(--accent-soft); stroke: var(--accent); stroke-width: 1.5; }
.arch-diagram .label { fill: var(--text); font: 600 14px "Inter", system-ui, sans-serif; }
.arch-diagram .sub { fill: var(--muted); font: 500 12px "Inter", system-ui, sans-serif; }
.arch-diagram .edge { stroke: var(--muted); stroke-width: 1.5; fill: none; }
.arch-diagram .edge-label { fill: var(--muted); font: 500 11px "Inter", system-ui, sans-serif; }
.arch-diagram .arrow { fill: var(--muted); }
.arch-points { display: grid; gap: 12px; margin-top: 20px; }
.arch-points li { position: relative; padding-left: 26px; color: var(--muted); }
.arch-points li::before {
  content: ""; position: absolute; left: 0; top: 0.55em; width: 12px; height: 12px; border-radius: 4px; background: var(--accent);
}
@media (min-width: 1024px) { .arch { grid-template-columns: 1fr 1.2fr; } }

/* Contact */
.contact-card {
  background: var(--surface); border: 1px solid var(--border); border-radius: 24px; box-shadow: var(--shadow);
  padding: clamp(28px, 5vw, 56px); text-align: center;
}
.contact-card .section-lead { margin-left: auto; margin-right: auto; }
.contact-email { display: inline-block; margin-top: 28px; font-size: clamp(1.15rem, 3.4vw, 1.8rem); font-weight: 700; word-break: break-all; }
.contact-card .hero-ctas, .contact-card .social { justify-content: center; }
.contact-card .social { margin-top: 24px; }

/* Footer */
.site-footer { border-top: 1px solid var(--border); padding: 28px 0; color: var(--muted); font-size: 0.92rem; }
.site-footer .container { display: flex; flex-wrap: wrap; gap: 8px 24px; justify-content: space-between; }
.site-footer a { color: var(--muted); }

/* Scroll reveal: only when JS is active and the visitor allows motion. */
@media (prefers-reduced-motion: no-preference) {
  .js .reveal { opacity: 0; transform: translateY(18px); transition: opacity .6s ease, transform .6s ease; }
  .js .reveal.revealed { opacity: 1; transform: none; }
}
''';
