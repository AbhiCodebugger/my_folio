BEGIN;

--
-- ACTION UPDATE DATA
--
UPDATE "user"
SET
  "resumeUrl" = 'https://drive.google.com/file/d/1cUR-YqYjj90HceYdHSjUVWhdsGyPQhof/view?usp=sharing',
  "updatedAt" = CURRENT_TIMESTAMP
WHERE "resumeUrl" IN (
  'https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=sharing',
  'https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=drive_link'
);

--
-- MIGRATION VERSION FOR myfolio
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('myfolio', '20260713114000000', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260713114000000', "timestamp" = now();

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
