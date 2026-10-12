# Design

## Context

See proposal.md (Why) for motivation and the specs for requirements. The current state that shapes the approach:

- Monorepo with three Dart packages: `myfolio_server` (Serverpod 3.4.5 on Render free tier, Neon Postgres), `myfolio_client` (generated client depending only on `serverpod_client` / `serverpod_auth_idp_client`, so it is pure Dart and usable outside Flutter), and `myfolio_flutter` (the current Flutter Web site deployed to GitHub Pages at `/my_folio/`).
- Content lives in six tables (`user`, `roles`, `projects`, `skills`, `experiences`, `educations`). It is seeded by hard-coded `create*` endpoint methods that anyone can call. Server integration tests call those methods to set up data.
- Project images are local assets (`myfolio_flutter/assets/images/*.webp`) matched by project title in `lib/utils/work_tab_assets.dart`. `Project.imageUrl` is empty in the DB.
- The résumé link comes from `User.resumeUrl`, with a fallback in `lib/utils/constants.dart` (`resumeUrlFor`) for legacy values.

```
 BEFORE                                           AFTER
 ------                                           -----
 Browser --> GH Pages (Flutter canvas)            CI (push / daily / manual)
    |                                                |
    +--> 6 RPCs --> Render (sleeps) --> Neon         +--> fetch once --> Render --> Neon
         (visitor waits 50 s)                        |    (retry <= 3 min, fail closed)
                                                     v
                                                  jaspr build (static HTML per page)
                                                     |
                                                     v
                                                  GH Pages /my_folio/  <-- Browser
                                                  (no API calls at view time)
```

## Goals / Non-Goals

**Goals:**
- Visitors get complete HTML on the first response, with zero runtime dependency on Render.
- Write all site code in Dart, reusing the generated `myfolio_client` models so the data schema has one source of truth.
- Use very little client-side JS: only the theme toggle, the mobile nav, and scroll reveal.
- Close the public write surface without losing the ability to seed a fresh database.

**Non-Goals:**
- No Flutter embedding (`jaspr_flutter_embed`) in this change.
- No data-model changes beyond the `phoneNumber` scope. Metrics and positioning copy live in site code for now.
- No runtime server rendering. Jaspr runs in static mode only.

## Decisions

### D1. Jaspr in static (SSG) mode as a new `myfolio_web` package
`myfolio_web/` is created with `jaspr create` in **static** mode. `jaspr build` runs the server-side entry point once, renders each route to HTML, and compiles only the `@client` components to JS.
- *Why:* real DOM/HTML gives SEO, link previews, and a fast LCP. The code stays in Dart with a component model close to Flutter's.
- *Alternatives:* (a) Keep Flutter Web and add a keep-alive ping. This fixes the wait but not SEO, payload size, or crawlability. (b) Flutter Web plus a static HTML snapshot in `index.html`. The content would be duplicated in two renderers. (c) Astro/Next.js. This leaves the Dart ecosystem, which the user ruled out. (d) Jaspr server mode on Render. This reintroduces cold starts.

### D2. Content is fetched once at build time through `myfolio_client`
The Jaspr server entry point (`lib/main.server.dart`) builds a `Client(API_URL)` from a `--dart-define`/env var. It calls `user.getUser`, `portfolio.getRoles/getProjectList/getSkills/getExperiences/getEducations` and `file.getResumeUrl` in parallel, wrapped in a retry loop (every 10 s, up to 3 min total). Then it passes an immutable `PortfolioContent` object into the component tree. If `getUser` returns null or the deadline passes, it throws, so `jaspr build` exits non-zero.
- *Why:* the generated client keeps types in sync with the server, and one fetch per build is cheap.
- *Alternatives:* raw HTTP/JSON calls (fallback only, see Risks), or a committed `content.json` snapshot (rejected in discussion: the DB stays the source of truth).

### D3. Site-level copy that isn't in the DB lives in `lib/content/site_config.dart`
This covers the positioning one-liner, impact metrics, the project-title → image map (ported from `work_tab_assets.dart`), the site URL/base path, the share-image path, and the architecture-section text. Résumé URL resolution ports `resumeUrlFor` (DB value → `getResumeUrl` → default).
- *Why:* this is presentation copy that changes with the design, not data. Moving it into DB models is a deliberate follow-up.

### D4. Page structure and components
One route (`/`) with anchored sections. The components mirror the spec order: `SiteHeader` (nav + theme toggle), `Hero`, `MetricsStrip`, `ProjectsSection` → `CaseStudyCard`, `ExperienceTimeline`, `SkillsSection`, `EducationSection`, `ArchitectureSection` (inline SVG diagram, so there's no extra request), `ContactSection`, `SiteFooter`. Head metadata is a `SeoHead` component that renders title, description, canonical, OG/Twitter tags, and JSON-LD `Person` from `PortfolioContent` + `SiteConfig`.
- `robots.txt` and `sitemap.xml` are static files under `web/` with the absolute site URL.
- The OG image is a static 1200x630 `web/images/og.png` made once from the profile photo + name/title.

### D5. Minimal interactivity
- **Theme:** an inline `<script>` in `<head>` sets `data-theme` on `<html>` from `localStorage` or `prefers-color-scheme` *before first paint*, so there's no flash. A small `@client` `ThemeToggle` flips it and persists the choice. Colors are CSS custom properties on `:root` / `[data-theme=dark]`.
- **Mobile nav:** a `@client` `MobileNav` disclosure button. Below 600 px the nav collapses behind it.
- **Scroll reveal:** an inline script adds a `js` class to `<html>` and uses `IntersectionObserver` to add `revealed` to sections. Hidden-until-revealed styles apply only under `.js` and only inside `@media (prefers-reduced-motion: no-preference)`. With no JS or reduced motion, content is always visible.
- *Why:* each piece degrades gracefully and stays tiny. No framework JS is needed for static sections.

### D6. Styling and assets
A single stylesheet (`lib/styles/site_css.dart`) is inlined into `<head>` as raw CSS, so first paint needs no stylesheet request. It uses a small token set of CSS custom properties (colors, radii, shadows) and breakpoints at 600/1024 px, matching the Flutter app's `Responsive` thresholds. Plain CSS was chosen over Jaspr's typed `css` API because custom properties, `color-mix`, and nested media queries are simpler to express directly. Use a system font stack plus one self-hosted variable font (Inter, `font-display: swap`, preloaded). Images are copied from `myfolio_flutter/assets/images/` into `myfolio_web/web/images/`, resized to ≤1200 px WebP (~270 KB total, down from ~4.9 MB), with explicit `width`/`height`, `loading="lazy"` below the fold, and an eagerly loaded profile photo.

### D7. Base path `/my_folio/`
All internal hrefs and asset URLs are built through one `sitePath()` helper prefixed with the base path, and `<base href="/my_folio/">` is emitted in the document head. The base path defaults to `/my_folio/` only in release builds (`jaspr build`) and to `/` under `jaspr serve`; otherwise dev serving 404s every asset and the client script, which silently disables the `@client` theme toggle and mobile nav. `--dart-define=BASE_PATH` overrides both. This is verified in CI by a link check over the build output.

### D8. Lock down the API (server)
- Delete `createRoles/createProjects/createSkills/createExperiences/createEducations` from `PortfolioEndpoint`, `createUser` from `UserEndpoint`, and `getUploadUrl` from `FileEndpoint`, then regenerate the client. Unknown methods are then rejected by Serverpod's dispatcher.
- Move the seed data verbatim into `lib/src/seed/portfolio_seed.dart` as `Future<void> seedPortfolio(Session session)`. For each table it inserts only when the table's row count is 0. This makes it idempotent per table.
- Add `bin/seed.dart`. It constructs `Serverpod(args, Protocol(), Endpoints())`, starts it, runs `seedPortfolio(await pod.createSession())`, then shuts down. The operator runs it locally against any run mode (`dart bin/seed.dart --mode production`) with `passwords.yaml` present.
- Set `phoneNumber` to `String?, scope=serverOnly` in `users/user.spy` (Serverpod requires server-only fields to be nullable). This needs one small, backward-compatible migration (`ALTER COLUMN "phoneNumber" DROP NOT NULL`) that runs on boot via `--apply-migrations`. Regenerate the client.
- Integration tests call `seedPortfolio` with the test session instead of endpoint methods. Add a test for seeding twice → same counts.
- *Alternatives:* keep the endpoints behind Serverpod auth scopes (`requiredScopes: {Scope.admin}`). Rejected because auth isn't wired up server-side, and an operator-only command is a smaller attack surface for content that changes rarely.

### D9. CI/CD
`deploy.yml` triggers on `push` to `main`, `workflow_dispatch`, and `schedule` (daily 03:00 UTC). It installs the Dart SDK (Flutter isn't needed), runs `dart pub get` in `myfolio_client` and `myfolio_web`, runs `dart pub global activate jaspr_cli`, then `jaspr build --dart-define=API_URL=https://my-folio-a91r.onrender.com`. A link check runs over `build/jaspr`, then it publishes that directory with `actions/deploy-pages` (or `peaceiris/actions-gh-pages`, kept for continuity). A failed build doesn't reach the publish step, so Pages keeps the previous deploy. `analyze.yml`/`format.yml` add a `myfolio_web` job.

### D10. Flutter app
Retired. Its uncommitted seeding hack was discarded and its calls to the removed endpoints deleted (tasks 2.1–2.2). The owner then chose to delete the `myfolio_flutter` package entirely in this change rather than keep an undeployed second UI. The server's `flutter_build` script and README sections that referenced it are removed with it.

## Risks / Trade-offs

- [Content changes take up to 24 h to appear] → Use the manual `workflow_dispatch` for immediate updates. This is acceptable for a portfolio.
- [`myfolio_client` or its auth dependency fails to compile under Jaspr's server/VM build] → Confirmed working: the client compiles and runs in the build.
- [`file.getResumeUrl` returns HTTP 500 in production (no `public` storage configured)] → The loader treats it as optional, and the endpoint now returns `null` instead of throwing.
- [Jaspr API churn (pre-1.0)] → Pin an exact `jaspr`/`jaspr_cli` version in `pubspec.yaml` and CI.
- [Render outage blocks deploys of code-only changes too] → Accepted: fail-closed keeps the live site intact. The retry window absorbs cold starts.
- [Seeding script binds server ports when run locally] → It's operator-only and short-lived. Document that it should be run with the local server stopped.
- [Removing endpoints breaks old Flutter web clients] → None will be deployed after this change.
- [Lighthouse ≥ 90 on mobile depends on image weight] → Images are already WebP. Size them to their rendered widths and preload only the hero image.

## Migration Plan

1. Ship the server changes (D8) first. Render auto-deploys, the public write surface closes, and reads are unaffected, so the current Flutter site keeps working.
2. Add `myfolio_web` and verify it locally with `jaspr serve` / `jaspr build` against the prod API.
3. Switch `deploy.yml` (D9). The next run replaces the Flutter build on Pages.
4. Verify on the live URL: Lighthouse, the link preview (LinkedIn Post Inspector), and `robots.txt`/`sitemap.xml`.

**Rollback:** revert this change's merge commit (it restores `myfolio_flutter` and the old `deploy.yml`) and re-run the deploy workflow to republish the Flutter build. The server changes are independent and don't need rolling back.

## Open Questions

- Final positioning one-liner and the exact metric figures. These are copy decisions that can be tuned in `site_config.dart` at any time.
