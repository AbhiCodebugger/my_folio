BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "work_skills" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "soft_skills" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "skills" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" json,
    "imageUrl" text,
    "proficiencyLevel" text DEFAULT 'intermediate'::text,
    "yearsOfExperience" bigint,
    "displayOrder" bigint DEFAULT 0
);


--
-- MIGRATION VERSION FOR myfolio
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('myfolio', '20260223141207538', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260223141207538', "timestamp" = now();

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
