import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../content/portfolio_content.dart';
import 'sections/architecture.dart';
import 'sections/background.dart';
import 'sections/common.dart';
import 'sections/contact.dart';
import 'sections/hero.dart';
import 'sections/projects.dart';
import 'seo_head.dart';
import 'site_chrome.dart';

/// The single-scroll portfolio page, rendered once at build time.
class PortfolioPage extends StatelessComponent {
  const PortfolioPage(this.content, {super.key});
  final PortfolioContent content;

  @override
  Component build(BuildContext context) {
    final name = content.profile.name;
    return Component.fragment([
      a(href: '#main', classes: 'skip-link', [t('Skip to content')]),
      SiteHeader(name: name),
      main_(id: 'main', [
        div(id: 'top', []),
        Hero(content),
        const MetricsStrip(),
        ProjectsSection(content.projects),
        ExperienceTimeline(content.experiences),
        SkillsSection(roles: content.roles, skills: content.skills),
        EducationSection(content.educations),
        const ArchitectureSection(),
        ContactSection(content),
      ]),
      SiteFooter(name: name),
      script(content: revealScript),
    ]);
  }
}
