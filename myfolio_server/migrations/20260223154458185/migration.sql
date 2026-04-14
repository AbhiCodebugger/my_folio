BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "experiences" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "experiences" (
    "id" bigserial PRIMARY KEY,
    "duration" text NOT NULL,
    "company" text NOT NULL,
    "position" text NOT NULL,
    "displayOrder" bigint DEFAULT 0,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- MIGRATION VERSION FOR myfolio
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('myfolio', '20260223154458185', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260223154458185', "timestamp" = now();

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
