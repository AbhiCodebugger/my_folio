BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "skills" DROP COLUMN "description";
ALTER TABLE "skills" DROP COLUMN "imageUrl";
ALTER TABLE "skills" DROP COLUMN "proficiencyLevel";
ALTER TABLE "skills" DROP COLUMN "yearsOfExperience";

--
-- MIGRATION VERSION FOR myfolio
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('myfolio', '20260223151425292', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260223151425292', "timestamp" = now();

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
    VALUES ('serverpod_auth_idp', '20260129181124635', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181124635', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
