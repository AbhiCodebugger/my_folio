import 'package:myfolio_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class PortfolioEndpoint extends Endpoint {
  Future<List<Roles>> getRoles(Session session) async {
    return await Roles.db.find(
      session,
      orderBy: (t) => t.displayOrder,
    );
  }

  Future<List<Project>> getProjectList(Session session) async {
    return await Project.db.find(
      session,
      where: (t) => t.isActive.equals(true),
      orderBy: (t) => t.id,
    );
  }

  Future<List<Roles>> createRoles(Session session) async {
    try {
      List<Roles> roles = [
        Roles(
          title: "Mobile Engineering",
          description:
              "5+ years building production-grade mobile applications with Flutter & Dart across iOS and Android. "
              "I architect scalable, modular codebases using clean architecture, BLoC/Provider/Riverpod state management, and platform channels. "
              "From complex animations and offline-first strategies to payment integrations and push notification pipelines — "
              "I ship polished apps that handle millions of user interactions.",
          displayOrder: 1,
        ),
        Roles(
          title: "AI-Augmented Development",
          description:
              "To accelerate delivery, I use tools like Cursor, Antigravity, and automated refactoring agents to prototype, iterate, and ship at 10x speed — turning complex AI workflows into production‑ready systems with the least friction and the most velocity"
              "I build intelligent endpoints with Serverpod and Dart, connecting models via REST to deliver real-time AI experiences on mobile.",
          displayOrder: 2,
        ),
        Roles(
          title: "Backend & System Design",
          description:
              "I design event-driven, microservice-ready backends with Serverpod, Golang"
              "My stack includes PostgreSQL, Firebase, Redis, and Docker for containerised deployments with CI/CD on GitHub Actions. "
              "I focus on API design, database modelling, migration strategies, and observability — "
              "ensuring systems are resilient, horizontally scalable, and easy to reason about.",
          displayOrder: 3,
        ),
        Roles(
          title: "UI/UX & Design Systems",
          description:
              "I bridge the gap between design and code by translating Figma specs into pixel-perfect, responsive Flutter UIs. "
              "I build reusable component libraries with theme-aware tokens (light/dark mode, adaptive typography, motion design) "
              "that keep the design language consistent across platforms while shipping faster with less duplication.",
          displayOrder: 4,
        ),
        Roles(
          title: "Open to What's Next",
          description:
              "Whether it's a high-growth startup needing an MVP in weeks or an enterprise modernising legacy mobile apps — I'm interested. "
              "I'm currently exploring Agentic AI, Generative AI workflows. "
              "If you're building something ambitious at the intersection of mobile and AI, let's talk.",
          displayOrder: 5,
        ),
      ];

      return await Roles.db.insert(session, roles);
    } on DatabaseException catch (e, st) {
      session.log(
        "Database error while creating skill ${e.message}",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    } catch (e, st) {
      session.log(
        "Unexpected error in createSkill : $e",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<List<Project>> createProjects(Session session) async {
    try {
      List<Project> projects = [
        Project(
          title: 'Market Intelligence Platform',
          description:
              'Architected a real-time news aggregation engine that ingests 10K+ articles/day via WebSocket streams. '
              'Implemented NLP-powered summarisation to distil content into 60-word briefs. '
              'Built a custom infinite-scroll feed with Hero animations and skeleton loading for sub-200ms perceived latency. '
              'Designed an offline-first caching layer with Hive, syncing deltas over background isolates.',
          imageUrl: '',
          techStack: ['Flutter', 'Dart', 'Node.js', 'Firebase', 'NLP'],
          isActive: true,
          projectUrl: '',
        ),
        Project(
          title: 'Freight & Logistics Suite',
          description:
              'Led development of a last-mile delivery platform serving 1000+ daily active drivers. '
              'Integrated Google Maps SDK with custom polyline routing and route optimization techniques using HERE SDK. '
              'Implemented SignalR push events to update the driver app in real-time. '
              'Offline support with Hive and stream to sync data.',
          imageUrl: '',
          techStack: [
            'Flutter',
            'Dart',
            '.NET',
          ],
          isActive: true,
          projectUrl: '',
        ),
        Project(
          title: 'Social Engagement Platform',
          description:
              'Engineered a content-sharing app with real-time chat (WebSocket), threaded comments, and media uploads to S3-compatible storage. '
              'Implemented a feed algorithm using a fan-out-on-write pattern for instant post delivery to followers. '
              'Built a modular notification system (push, in-app, email digest) with Firebase Cloud Messaging. '
              'Achieved 60fps scroll performance via lazy image loading and widget recycling.',
          imageUrl: '',
          techStack: ['Flutter', 'Dart', 'Node.js', 'WebSocket', 'FCM'],
          isActive: true,
          projectUrl: '',
        ),
        Project(
          title: 'E-Commerce Marketplace',
          description:
              'Developed a full-featured marketplace with product catalogue, search with filters, cart management, and Stripe payment integration. '
              'Designed a clean architecture codebase with BLoC state management, repository pattern, and dependency injection via GetIt. '
              'Implemented deep linking, dynamic theming, and A/B testable UI variants. '
              'Built an admin dashboard for inventory, orders, and revenue analytics.',
          imageUrl: '',
          techStack: [
            'Flutter',
            'Dart',
            '.NET',
            'Stripe',
          ],
          isActive: true,
          projectUrl: '',
        ),
        Project(
          title: 'HealthVitals Tracker',
          description:
              'Built a HIPAA-aware health monitoring app tracking blood pressure, heart rate over time. '
              'Integrated graph to show data daily, weekly, monthly, yearly. '
              'Implemented appointment booking system with calendar view.',
          imageUrl: '',
          techStack: [
            'Flutter',
            'Dart',
            'Node.js',
          ],
          isActive: true,
          projectUrl: '',
        ),
      ];

      return await Project.db.insert(session, projects);
    } on DatabaseException catch (e, st) {
      session.log(
        "Database error while creating work skill ${e.message}",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    } catch (e, st) {
      session.log(
        "Unexpected error in createWorkSkill : $e",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<List<Skill>> createSkills(Session session) async {
    try {
      final skillNames = [
        "Flutter & Dart",
        "Architect",
        "Version control",
        "Android/iOS",
        "AI Orchestration",
        "Firebase",
        "App Security",
        "CI/CD",
        "MVVM",
        "BloC/Provider/Riverpod",
        "System Design",
      ];
      final skills = skillNames
          .asMap()
          .entries
          .map((e) => Skill(name: e.value, displayOrder: e.key))
          .toList();
      return await Skill.db.insert(session, skills);
    } on DatabaseException catch (e, st) {
      session.log(
        "Database error while creating skills: ${e.message}",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    } catch (e, st) {
      session.log(
        "Unexpected error in createSkills: $e",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<List<Skill>> getSkills(Session session) async {
    return await Skill.db.find(
      session,
      orderBy: (t) => t.displayOrder,
    );
  }

  Future<List<Experience>> createExperiences(Session session) async {
    try {
      List<Experience> experiences = [
        Experience(
          duration: 'April 2024 - Present',
          company: 'R System International',
          position: 'Senior Software Engineer',
        ),
        Experience(
          duration: 'Sep 2022 - March2024',
          company: 'Virtual Employee Pvt. Ltd.',
          position: 'Software Engineer',
        ),
        Experience(
          duration: 'April 2021 - August 2022',
          company: 'TechConfer Technologies Pvt. Ltd.',
          position: 'Flutter Developer',
        ),
        Experience(
          duration: 'June 2020 - Jan 2021',
          company: 'Trivy Technologies Pvt. Ltd.',
          position: 'Flutter Intern',
        ),
      ];
      return await Experience.db.insert(session, experiences);
    } on DatabaseException catch (e, st) {
      session.log(
        "Database error while creating experiences: ${e.message}",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<List<Experience>> getExperiences(Session session) async {
    return await Experience.db.find(
      session,
      orderBy: (t) => t.displayOrder,
    );
  }

  Future<List<Education>> createEducations(Session session) async {
    try {
      List<Education> educations = [
        Education(
          duration: '2014-2018',
          institution: 'PTU',
          degree: 'B.Tech',
          fieldOfStudy: 'Computer Science and Engineering',
        ),
        Education(
          duration: '2011-2013',
          institution: 'B.S.E.B',
          degree: '12th',
          fieldOfStudy: 'Science',
        ),
        Education(
          duration: '2010-2011',
          institution: 'C.B.S.E',
          degree: '10th',
          fieldOfStudy: '',
        ),
      ];
      return await Education.db.insert(session, educations);
    } on DatabaseException catch (e, st) {
      session.log(
        "Database error while creating educations: ${e.message}",
        level: LogLevel.error,
        exception: e,
        stackTrace: st,
      );
      rethrow;
    }
  }

  Future<List<Education>> getEducations(Session session) async {
    return await Education.db.find(
      session,
      orderBy: (t) => t.displayOrder,
    );
  }
}
