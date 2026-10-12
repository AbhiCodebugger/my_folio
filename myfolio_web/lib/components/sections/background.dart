import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:myfolio_client/myfolio_client.dart';

import 'common.dart';

class ExperienceTimeline extends StatelessComponent {
  const ExperienceTimeline(this.experiences, {super.key});

  /// Ordered by display order, most recent first (as returned by the API).
  final List<Experience> experiences;

  @override
  Component build(BuildContext context) {
    return pageSection(
      id: 'experience',
      eyebrow: 'Career',
      title: 'Experience',
      alt: true,
      children: [
        ol(classes: 'timeline', [
          for (final e in experiences)
            li(classes: 'timeline-item', [
              div(classes: 'timeline-row', [
                h3([t(e.position)]),
                span(classes: 'timeline-duration', [t(e.duration)]),
              ]),
              div(classes: 'timeline-company', [t(e.company)]),
            ]),
        ]),
      ],
    );
  }
}

class SkillsSection extends StatelessComponent {
  const SkillsSection({required this.roles, required this.skills, super.key});
  final List<Roles> roles;
  final List<Skill> skills;

  @override
  Component build(BuildContext context) {
    return pageSection(
      id: 'skills',
      eyebrow: 'Expertise',
      title: 'What I bring',
      children: [
        if (roles.isNotEmpty)
          div(classes: 'roles', [
            for (final r in roles)
              article(classes: 'role', [
                h3([t(r.title)]),
                p([t(r.description)]),
              ]),
          ]),
        ul(
          classes: 'skill-list',
          attributes: {'aria-label': 'Skills'},
          [
            for (final s in skills) li([t(s.name)]),
          ],
        ),
      ],
    );
  }
}

class EducationSection extends StatelessComponent {
  const EducationSection(this.educations, {super.key});
  final List<Education> educations;

  @override
  Component build(BuildContext context) {
    return pageSection(
      id: 'education',
      eyebrow: 'Foundation',
      title: 'Education',
      alt: true,
      children: [
        ul(classes: 'edu-list', [
          for (final e in educations)
            li(classes: 'edu', [
              h3([
                t(e.fieldOfStudy.trim().isEmpty ? e.degree : '${e.degree} — ${e.fieldOfStudy}'),
              ]),
              div(classes: 'edu-institution', [t(e.institution)]),
              div(classes: 'edu-duration', [t(e.duration)]),
            ]),
        ]),
      ],
    );
  }
}
