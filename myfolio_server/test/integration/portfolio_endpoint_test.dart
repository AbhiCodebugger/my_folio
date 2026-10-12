import 'package:myfolio_server/src/generated/protocol.dart';
import 'package:myfolio_server/src/seed/portfolio_seed.dart';
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
        await seedPortfolio(sessionBuilder.build());

        final roles = await endpoints.portfolio.getRoles(sessionBuilder);

        expect(roles, isNotEmpty);
        final orders = roles.map((r) => r.displayOrder).toList();
        final sorted = [...orders]..sort();
        expect(
          orders,
          sorted,
          reason: 'roles should be ordered by displayOrder',
        );
      });
    });

    group('when skills are seeded', () {
      test('then getSkills returns them ordered by displayOrder', () async {
        await seedPortfolio(sessionBuilder.build());

        final skills = await endpoints.portfolio.getSkills(sessionBuilder);

        expect(skills, isNotEmpty);
        final orders = skills.map((s) => s.displayOrder).toList();
        final sorted = [...orders]..sort();
        expect(orders, sorted);
      });
    });

    group('when projects are seeded', () {
      test('then getProjectList returns only active projects', () async {
        await seedPortfolio(sessionBuilder.build());

        final projects = await endpoints.portfolio.getProjectList(
          sessionBuilder,
        );

        expect(projects, isNotEmpty);
        expect(projects.every((p) => p.isActive), isTrue);
      });
    });

    group('when experiences are seeded', () {
      test('then getExperiences returns them', () async {
        await seedPortfolio(sessionBuilder.build());

        final experiences = await endpoints.portfolio.getExperiences(
          sessionBuilder,
        );

        expect(experiences, isNotEmpty);
        final orders = experiences.map((e) => e.displayOrder).toList();
        final sorted = [...orders]..sort();
        expect(orders, sorted);
      });
    });

    group('when educations are seeded', () {
      test('then getEducations returns them', () async {
        await seedPortfolio(sessionBuilder.build());

        final educations = await endpoints.portfolio.getEducations(
          sessionBuilder,
        );

        expect(educations, isNotEmpty);
      });
    });

    group('when seeding runs twice', () {
      test('then no table gains duplicate rows', () async {
        final session = sessionBuilder.build();
        await seedPortfolio(session);

        Future<List<int>> counts() async => [
          await User.db.count(session),
          await Roles.db.count(session),
          await Project.db.count(session),
          await Skill.db.count(session),
          await Experience.db.count(session),
          await Education.db.count(session),
        ];

        final first = await counts();
        expect(first.every((c) => c > 0), isTrue);

        await seedPortfolio(session);

        expect(await counts(), first);
      });
    });
  });
}
