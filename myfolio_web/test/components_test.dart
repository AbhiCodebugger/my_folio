import 'dart:convert';

import 'package:jaspr/server.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_web/components/sections/background.dart';
import 'package:myfolio_web/components/sections/projects.dart';
import 'package:myfolio_web/main.server.options.dart';
import 'package:test/test.dart';

Future<String> render(Component component) async {
  final response = await renderComponent(component, standalone: true);
  return utf8.decode(response.body);
}

void main() {
  setUpAll(() => Jaspr.initializeApp(options: defaultServerOptions));

  group('CaseStudyCard', () {
    test('renders no project link when the URL is empty', () async {
      final html = await render(
        CaseStudyCard(
          Project(
            title: 'HealthVitals Tracker',
            description: 'd',
            projectUrl: '',
            techStack: ['Flutter'],
            isActive: true,
          ),
          index: 0,
        ),
      );

      expect(html, isNot(contains('case-link')));
      expect(html, contains('alt="Illustration for HealthVitals Tracker"'));
      expect(html, contains('Flutter'));
    });

    test('links to the project when a URL is present', () async {
      final html = await render(
        CaseStudyCard(
          Project(
            title: 'X',
            description: 'd',
            projectUrl: 'https://example.com/x',
            isActive: true,
          ),
          index: 0,
        ),
      );

      expect(html, contains('href="https://example.com/x"'));
    });

    test('section hides inactive projects', () async {
      final html = await render(
        ProjectsSection([
          Project(title: 'Shown', description: 'd', isActive: true),
          Project(title: 'Hidden', description: 'd', isActive: false),
        ]),
      );

      expect(html, contains('Shown'));
      expect(html, isNot(contains('Hidden')));
    });
  });

  test('ExperienceTimeline keeps the given (display) order', () async {
    final html = await render(
      ExperienceTimeline([
        Experience(duration: '2024 - Present', company: 'A', position: 'Senior'),
        Experience(duration: '2022 - 2024', company: 'B', position: 'Mid'),
        Experience(duration: '2020 - 2022', company: 'C', position: 'Junior'),
      ]),
    );

    final senior = html.indexOf('Senior');
    final mid = html.indexOf('Mid');
    final junior = html.indexOf('Junior');
    expect(senior, greaterThan(-1));
    expect(senior < mid && mid < junior, isTrue);
  });

  group('EducationSection', () {
    test('omits the separator when field of study is empty', () async {
      final html = await render(
        EducationSection([
          Education(duration: '2010', institution: 'C.B.S.E', degree: '10th', fieldOfStudy: ''),
        ]),
      );

      expect(html, contains('<h3>10th</h3>'));
      expect(html, isNot(contains('10th —')));
    });

    test('joins degree and field of study when present', () async {
      final html = await render(
        EducationSection([
          Education(duration: '2014', institution: 'PTU', degree: 'B.Tech', fieldOfStudy: 'CSE'),
        ]),
      );

      expect(html, contains('B.Tech — CSE'));
    });
  });
}
