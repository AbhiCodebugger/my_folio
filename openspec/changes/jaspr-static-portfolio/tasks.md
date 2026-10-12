# Tasks

## 1. Lock down the content API (server)

- [x] 1.1 Move the seed data from the `create*` endpoint methods and `createUser` into `myfolio_server/lib/src/seed/portfolio_seed.dart` as `seedPortfolio(Session)`, inserting per table only when the table is empty. Verify `dart analyze` in `myfolio_server` is clean.
- [x] 1.2 Delete the `create*` methods from `PortfolioEndpoint`, `createUser` from `UserEndpoint`, and `getUploadUrl` from `FileEndpoint`. Verify by grepping `myfolio_server/lib/src/endpoints/` for `create`/`getUploadUrl`, which should return nothing.
- [x] 1.3 Set `phoneNumber` to `String?, scope=serverOnly` in `myfolio_server/lib/src/models/users/user.spy`, run `serverpod generate`, and create the migration. Verify `myfolio_client/lib/src/protocol/users/user.dart` has no `phoneNumber` and the new migration only contains `ALTER COLUMN "phoneNumber" DROP NOT NULL`.
- [x] 1.4 Add `myfolio_server/bin/seed.dart` that starts the pod, runs `seedPortfolio`, and shuts down. Verify by running it twice against the local docker DB: the second run leaves all six table counts unchanged.
- [x] 1.5 Update `test/integration/portfolio_endpoint_test.dart` and `user_endpoint_test.dart` to set up data through `seedPortfolio`. Add tests for "seeding twice keeps counts" and "getUser response has no phone number". Verify `dart test` passes in `myfolio_server`.
- [x] 1.6 Document seeding (`dart bin/seed.dart --mode <mode>`) and the removed endpoints in README. Verify the documented command runs locally as written.

## 2. Keep the Flutter app compiling

- [x] 2.1 Discard the uncommitted `myfolio_flutter/lib/screens/desktop_layout.dart` change so "Download resume" opens `resumeUrlFor(user)` again. Verify with `git diff` that the file matches `HEAD`.
- [x] 2.2 Remove `createRoles/createProjects/createSkills/createExperiences/createEducations/addUserData/uploadResume` and any callers from `myfolio_flutter`. Verify `flutter analyze` and `flutter test` pass in `myfolio_flutter`.

## 3. Scaffold the Jaspr site

- [x] 3.1 Create `myfolio_web/` with `jaspr create` in static mode, pinning exact `jaspr`/`jaspr_builder`/`jaspr_cli` versions, and add a path dependency on `../myfolio_client`. Verify `dart pub get` succeeds and `jaspr build` produces `build/jaspr/index.html`.
- [x] 3.2 Add `lib/content/site_config.dart` (base path `/my_folio/`, site URL, positioning line, metrics, project-image map ported from `work_tab_assets.dart`, default résumé URL ported from `constants.dart`, architecture copy) with a `sitePath()` helper (`path` clashes with the SVG element). Verify with a unit test that `sitePath('images/a.webp')` returns `/my_folio/images/a.webp`.
- [x] 3.3 Copy `profile_pic.jpg` and the five project images into `myfolio_web/web/images/` (resized to ≤1200 px WebP; the photo becomes `profile.webp`), add the self-hosted Inter font, and create a 1200x630 `og.png`. Verify that all files exist and `og.png` is 1200x630.

## 4. Build-time content loading

- [x] 4.1 Implement `PortfolioContent` and a loader in `lib/content/` that reads `API_URL`, fetches all seven calls in parallel through `myfolio_client` with a 10 s retry up to 3 min, and throws when the profile is null or the deadline passes. Verify with unit tests using a fake client: success, cold start that recovers, timeout, and missing profile.
- [x] 4.2 Wire the loader into `lib/main.server.dart` so content is awaited before rendering. Verify `jaspr build --dart-define=API_URL=https://my-folio-a91r.onrender.com` puts the real name and project titles in `build/jaspr/index.html`, and that a build against an unreachable URL exits non-zero.

## 5. Page sections

- [x] 5.1 Build the layout shell: design tokens, light/dark CSS variables, breakpoints at 600/1024, the `SiteHeader` with anchor nav, and `SiteFooter`. Verify at 320/768/1440 px in `jaspr serve` that there's no horizontal scroll.
- [x] 5.2 Build `Hero` (name, title, positioning, location, photo, social links, "Download résumé" in a new tab, "Contact me" → `#contact`) and `MetricsStrip`. Verify the metrics strip is visible above the fold at 1440x900 and both CTAs work.
- [x] 5.3 Build `ProjectsSection`/`CaseStudyCard` (image with alt text, description, tech labels, link only when a URL is present, active projects only). Verify with a component test that an empty URL renders no link.
- [x] 5.4 Build `ExperienceTimeline`, `SkillsSection`, and `EducationSection` in display order, with no empty separator for a missing field of study. Verify with component tests for ordering and the empty field-of-study case.
- [x] 5.5 Build `ArchitectureSection` with an inline SVG diagram (static site ← CI ← Serverpod ← Postgres) and `ContactSection` (mailto email, social links, no phone). Verify that the build output contains the SVG and contains no phone number.

## 6. Interactivity, accessibility, SEO

- [x] 6.1 Add the pre-paint theme script and a `@client` `ThemeToggle` that persists to `localStorage`. Verify there's no light-theme flash under OS dark mode and that a manual choice survives a reload.
- [x] 6.2 Add a `@client` `MobileNav` (collapses below 600 px) and the scroll-reveal script, gated on `.js` and `prefers-reduced-motion: no-preference`. Verify that with JS disabled, and separately with reduced motion on, all sections are visible with no animation.
- [x] 6.3 Add `SeoHead` (title, description, canonical, OG/Twitter with `og.png`, JSON-LD `Person`) plus `web/robots.txt` and `web/sitemap.xml`. Verify locally that the JSON-LD parses with all required `Person` fields and that every OG/Twitter tag is present (the Schema.org validator and OG preview tools need a public URL, so they run against the live site in 8.3).
- [x] 6.4 Do an accessibility pass: landmarks, heading order, focus-visible styles, AA contrast in both themes. Verify Lighthouse Accessibility is ≥ 90 locally and that tabbing reaches every link in order.
- [x] 6.5 Add a `myfolio_web/README.md` covering local dev (`jaspr serve`), build with `API_URL`, and where site copy lives. Verify the commands run as written.

## 7. CI/CD and docs

- [ ] 7.1 Rewrite `.github/workflows/deploy.yml`: push/dispatch/daily schedule, Dart-only setup, `jaspr build` with `API_URL`, a link check over `build/jaspr` under `/my_folio/`, then publish `build/jaspr` (no Flutter build). Verify a manual dispatch run succeeds and the published artifact contains no `flutter_bootstrap.js`.
- [x] 7.2 Add `myfolio_web` analyze, format, and unit-test jobs to `analyze.yml`/`format.yml`/`tests.yml`. Verify they pass on a PR.
- [x] 7.3 Update the root README (structure table, architecture diagram, build/deploy flow, content-update flow via DB edit + dispatch, rollback). Verify that all relative links in the README resolve.

## 8. Integration checks

- [ ] 8.1 On the live URL, verify every section renders with JS disabled, no network calls go to `onrender.com` (DevTools), and all assets load without a 404.
- [ ] 8.2 Run Lighthouse mobile on the live home page. Verify LCP < 2.5 s and Performance/SEO/Accessibility/Best Practices are each ≥ 90.
- [ ] 8.3 Check the link preview in LinkedIn Post Inspector and fetch `/my_folio/robots.txt` and `/my_folio/sitemap.xml`. Verify that the preview shows name, title, and image, and that both files are served.
- [ ] 8.4 Confirm the removed RPCs (`portfolio.createRoles`, `user.createUser`, `file.getUploadUrl`) are rejected by the production API and that row counts in Neon are unchanged.

## Workflow follow-up

- Archive the change once the integration checks pass.
- Follow-up changes to consider: a server-backed contact form, richer models (experience highlights, case-study fields), a custom domain, analytics.
