import 'dart:convert';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/portfolio_content.dart';
import '../content/site_config.dart';
import '../styles/site_css.dart';

/// Applies the saved or OS theme before first paint and enables scroll
/// reveal only when IntersectionObserver exists.
const _prePaintScript = '''
(function(){var d=document.documentElement;try{var t=localStorage.getItem('theme');if(t==='light'||t==='dark'){d.setAttribute('data-theme',t)}else if(window.matchMedia&&matchMedia('(prefers-color-scheme: dark)').matches){d.setAttribute('data-theme','dark')}}catch(e){}if('IntersectionObserver' in window){d.classList.add('js')}})();''';

/// Reveals `.reveal` blocks as they scroll into view, and immediately reveals
/// any already scrolled past (e.g. after jumping to an anchor).
const revealScript = '''
(function(){if(!('IntersectionObserver' in window))return;var io=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting||e.boundingClientRect.top<0){e.target.classList.add('revealed');io.unobserve(e.target)}})},{rootMargin:'0px 0px -8% 0px'});document.querySelectorAll('.reveal').forEach(function(el){io.observe(el)})})();''';

String pageTitle(PortfolioContent c) => '${c.profile.name} — ${c.profile.title}';

/// Meta description: site copy, falling back to the profile summary.
String description(PortfolioContent c) => metaDescription.isNotEmpty ? metaDescription : c.profile.summary;

/// Everything inside `<head>` besides title/charset/viewport.
List<Component> seoHead(PortfolioContent c) {
  final title = pageTitle(c);
  final desc = description(c);
  final ogImage = absoluteUrl('images/og.png');

  final jsonLd = jsonEncode({
    '@context': 'https://schema.org',
    '@type': 'Person',
    'name': c.profile.name,
    'jobTitle': c.profile.title,
    'description': c.profile.summary,
    'url': siteUrl,
    'image': absoluteUrl('images/profile.webp'),
    'email': 'mailto:${c.profile.email}',
    if (c.profile.location.isNotEmpty) 'address': {'@type': 'PostalAddress', 'addressLocality': c.profile.location},
    'sameAs': c.profile.socialUrls,
    'knowsAbout': [for (final s in c.skills) s.name],
  }).replaceAll('</', r'<\/');

  Component prop(String property, String content) => meta(attributes: {'property': property}, content: content);

  return [
    script(content: _prePaintScript),
    meta(name: 'description', content: desc),
    meta(name: 'author', content: c.profile.name),
    meta(name: 'theme-color', content: '#4338ca'),
    link(rel: 'canonical', href: siteUrl),
    link(rel: 'icon', href: sitePath('favicon.png'), type: 'image/png'),
    link(rel: 'apple-touch-icon', href: sitePath('images/icon-192.png')),
    link(
      rel: 'preload',
      href: sitePath('fonts/inter-var-latin.woff2'),
      as: 'font',
      type: 'font/woff2',
      attributes: {'crossorigin': ''},
    ),
    link(rel: 'preload', href: sitePath('images/profile.webp'), as: 'image', attributes: {'fetchpriority': 'high'}),
    // Open Graph / Twitter
    prop('og:type', 'profile'),
    prop('og:site_name', c.profile.name),
    prop('og:title', title),
    prop('og:description', desc),
    prop('og:url', siteUrl),
    prop('og:image', ogImage),
    prop('og:image:width', '1200'),
    prop('og:image:height', '630'),
    prop('og:image:alt', '${c.profile.name}, ${c.profile.title}'),
    prop('profile:first_name', c.profile.name.split(' ').first),
    if (c.profile.name.contains(' ')) prop('profile:last_name', c.profile.name.split(' ').skip(1).join(' ')),
    meta(name: 'twitter:card', content: 'summary_large_image'),
    meta(name: 'twitter:title', content: title),
    meta(name: 'twitter:description', content: desc),
    meta(name: 'twitter:image', content: ogImage),
    script(attributes: {'type': 'application/ld+json'}, content: jsonLd),
    Component.element(tag: 'style', children: [RawText(siteCss())]),
  ];
}
