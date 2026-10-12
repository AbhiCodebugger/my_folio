import 'package:myfolio_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// Seeds portfolio content into an empty database.
///
/// Each table is only seeded while it has no rows, so running this more than
/// once never creates duplicates. Content is edited directly in the database
/// after the first seed.
Future<void> seedPortfolio(Session session) async {
  if (await User.db.count(session) == 0) {
    await User.db.insertRow(session, _user());
    session.log('Seeded user');
  }
  if (await Roles.db.count(session) == 0) {
    await Roles.db.insert(session, _roles());
    session.log('Seeded roles');
  }
  if (await Project.db.count(session) == 0) {
    await Project.db.insert(session, _projects());
    session.log('Seeded projects');
  }
  if (await Skill.db.count(session) == 0) {
    await Skill.db.insert(session, _skills());
    session.log('Seeded skills');
  }
  if (await Experience.db.count(session) == 0) {
    await Experience.db.insert(session, _experiences());
    session.log('Seeded experiences');
  }
  if (await Education.db.count(session) == 0) {
    await Education.db.insert(session, _educations());
    session.log('Seeded educations');
  }
}

User _user() {
  return User(
    name: "Abhinav Ranjan",
    imagePath: "",
    title: "Senior Flutter Developer",
    socialUrls: [
      'https://www.linkedin.com/in/abhinav-ranjan-78589aa3/',
      'https://github.com/AbhiCodebugger',
      'https://stackoverflow.com/users/14939199/abhinav',
    ],
    summary:
        "Senior Mobile Engineer with deep expertise in Flutter, architecture, and system design. I focus on building fast, reliable cross‑platform applications and shaping technical direction from idea to delivery. I use AI‑assisted development tools to speed up prototyping, improve code quality, and streamline everyday engineering work. I enjoy helping teams work more effectively and ensuring the product is built on a strong, scalable foundation.",
    phoneNumber: '07009789470',
    email: "ranjansme12@gmail.com",
    location: "Noida, India",
    resumeUrl:
        'https://drive.google.com/file/d/1cUR-YqYjj90HceYdHSjUVWhdsGyPQhof/view?usp=sharing',
  );
}

List<Roles> _roles() {
  return [
    Roles(
      title: "Mobile Engineering",
      description:
          "6+ years building production-grade mobile applications with Flutter & Dart across iOS and Android. "
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
          "I design event-driven, microservice-ready backends with Serverpod and Golang. "
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
}

List<Project> _projects() {
  return [
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
}

List<Skill> _skills() {
  final skillNames = [
    "Flutter & Dart",
    "Kotlin",
    "Android/iOS",
    "AI Orchestration",
    "Firebase",
    "App Security",
    "CI/CD",
    "MVVM/Clean Architecture",
    "BloC/Provider/Riverpod",
    "System Design",
  ];
  return skillNames
      .asMap()
      .entries
      .map((e) => Skill(name: e.value, displayOrder: e.key))
      .toList();
}

List<Experience> _experiences() {
  return [
    Experience(
      duration: 'April 2024 - Present',
      company: 'R System International',
      position: 'Senior Software Engineer',
      displayOrder: 0,
    ),
    Experience(
      duration: 'Sep 2022 - March 2024',
      company: 'Virtual Employee Pvt. Ltd.',
      position: 'Software Engineer',
      displayOrder: 1,
    ),
    Experience(
      duration: 'April 2021 - August 2022',
      company: 'TechConfer Technologies Pvt. Ltd.',
      position: 'Flutter Developer',
      displayOrder: 2,
    ),
    Experience(
      duration: 'June 2020 - Jan 2021',
      company: 'Trivy Technologies Pvt. Ltd.',
      position: 'Junior Flutter Developer',
      displayOrder: 3,
    ),
  ];
}

List<Education> _educations() {
  return [
    Education(
      duration: '2014-2018',
      institution: 'PTU',
      degree: 'B.Tech',
      fieldOfStudy: 'Computer Science and Engineering',
      displayOrder: 0,
    ),
    Education(
      duration: '2011-2013',
      institution: 'B.S.E.B',
      degree: '12th',
      fieldOfStudy: 'Science',
      displayOrder: 1,
    ),
    Education(
      duration: '2010-2011',
      institution: 'C.B.S.E',
      degree: '10th',
      fieldOfStudy: '',
      displayOrder: 2,
    ),
  ];
}
