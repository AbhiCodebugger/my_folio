import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given PortfolioEndpoint', (sessionBuilder, endpoints) {
    group('when no data has been seeded', () {
      test('then getRoles returns an empty list', () async {
        final roles = await endpoints.portfolio.getRoles(sessionBuilder);
        expect(roles, isEmpty);
      });

      test('then getSkills returns an empty list', () async {
        final skills = await endpoints.portfolio.getSkills(sessionBuilder);
        expect(skills, isEmpty);
      });

      test('then getProjectList returns an empty list', () async {
        final projects = await endpoints.portfolio.getProjectList(
          sessionBuilder,
        );
        expect(projects, isEmpty);
      });
    });

    group('when roles are seeded', () {
      test('then getRoles returns them ordered by displayOrder', () async {
        await endpoints.portfolio.createRoles(sessionBuilder);

        final roles = await endpoints.portfolio.getRoles(sessionBuilder);

        expect(roles, isNotEmpty);
        final orders = roles.map((r) => r.displayOrder).toList();
        final sorted = [...orders]..sort();
        expect(orders, sorted, reason: 'roles should be ordered by displayOrder');
      });
    });

    group('when skills are seeded', () {
      test('then getSkills returns them ordered by displayOrder', () async {
        await endpoints.portfolio.createSkills(sessionBuilder);

        final skills = await endpoints.portfolio.getSkills(sessionBuilder);

        expect(skills, isNotEmpty);
        final orders = skills.map((s) => s.displayOrder).toList();
        final sorted = [...orders]..sort();
        expect(orders, sorted);
      });
    });

    group('when projects are seeded', () {
      test('then getProjectList returns only active projects', () async {
        await endpoints.portfolio.createProjects(sessionBuilder);

        final projects = await endpoints.portfolio.getProjectList(
          sessionBuilder,
        );

        expect(projects, isNotEmpty);
        expect(projects.every((p) => p.isActive), isTrue);
      });
    });

    group('when experiences are seeded', () {
      test('then getExperiences returns them', () async {
        await endpoints.portfolio.createExperiences(sessionBuilder);

        final experiences = await endpoints.portfolio.getExperiences(
          sessionBuilder,
        );

        expect(experiences, isNotEmpty);
      });
    });

    group('when educations are seeded', () {
      test('then getEducations returns them', () async {
        await endpoints.portfolio.createEducations(sessionBuilder);

        final educations = await endpoints.portfolio.getEducations(
          sessionBuilder,
        );

        expect(educations, isNotEmpty);
      });
    });
  });
}
