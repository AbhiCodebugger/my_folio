BEGIN;

--
-- ACTION UPDATE DATA
--
UPDATE "roles"
SET
  "description" = '6+ years building production-grade mobile applications with Flutter & Dart across iOS and Android. I architect scalable, modular codebases using clean architecture, BLoC/Provider/Riverpod state management, and platform channels. From complex animations and offline-first strategies to payment integrations and push notification pipelines — I ship polished apps that handle millions of user interactions.',
  "updatedAt" = CURRENT_TIMESTAMP
WHERE "title" = 'Mobile Engineering'
  AND "description" LIKE '5+ years building production-grade mobile applications%';

UPDATE "roles"
SET
  "description" = 'I design event-driven, microservice-ready backends with Serverpod and Golang. My stack includes PostgreSQL, Firebase, Redis, and Docker for containerised deployments with CI/CD on GitHub Actions. I focus on API design, database modelling, migration strategies, and observability — ensuring systems are resilient, horizontally scalable, and easy to reason about.',
  "updatedAt" = CURRENT_TIMESTAMP
WHERE "title" = 'Backend & System Design'
  AND "description" LIKE '%with Serverpod, Golang%';

UPDATE "experiences"
SET
  "position" = 'Junior Flutter Developer',
  "updatedAt" = CURRENT_TIMESTAMP
WHERE "company" = 'Trivy Technologies Pvt. Ltd.'
  AND "position" = 'Flutter Intern';

--
-- MIGRATION VERSION FOR myfolio
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('myfolio', '20260907150717000', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260907150717000', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
