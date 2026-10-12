import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:myfolio_client/myfolio_client.dart';

import '../../content/site_config.dart';
import '../icons.dart';
import 'common.dart';

class ProjectsSection extends StatelessComponent {
  const ProjectsSection(this.projects, {super.key});
  final List<Project> projects;

  @override
  Component build(BuildContext context) {
    final active = projects.where((project) => project.isActive).toList();
    return pageSection(
      id: 'projects',
      eyebrow: 'Selected work',
      title: 'Case studies',
      lead:
          'Production apps I designed, built and shipped — the problems, the '
          'approach, and the stack behind them.',
      children: [
        div(classes: 'projects', [
          for (final (i, project) in active.indexed) CaseStudyCard(project, index: i),
        ]),
      ],
    );
  }
}

class CaseStudyCard extends StatelessComponent {
  const CaseStudyCard(this.project, {required this.index, super.key});
  final Project project;
  final int index;

  @override
  Component build(BuildContext context) {
    final image = project.imageUrl?.isNotEmpty == true ? project.imageUrl : projectImageFor(project.title);
    final size = image == null ? null : imageSizes[image];
    final url = project.projectUrl;
    final tech = project.techStack ?? const <String>[];

    return article(classes: 'case', [
      if (image != null)
        div(classes: 'case-media', [
          img(
            src: image.startsWith('http') ? image : sitePath(image),
            alt: 'Illustration for ${project.title}',
            width: size?.$1,
            height: size?.$2,
            loading: MediaLoading.lazy,
            attributes: {'decoding': 'async'},
          ),
        ]),
      div(classes: 'case-body', [
        span(classes: 'case-index', [t((index + 1).toString().padLeft(2, '0'))]),
        h3([t(project.title)]),
        p([t(project.description)]),
        if (tech.isNotEmpty)
          ul(
            classes: 'chips',
            attributes: {'aria-label': 'Tech stack'},
            [
              for (final item in tech) li(classes: 'chip', [t(item)]),
            ],
          ),
        if (url != null && url.isNotEmpty)
          a(
            href: url,
            target: Target.blank,
            classes: 'case-link',
            attributes: {'rel': 'noopener noreferrer'},
            [t('View project '), RawText(iconArrowUpRight)],
          ),
      ]),
    ]);
  }
}
