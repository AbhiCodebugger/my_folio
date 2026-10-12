# Proposal

## Why

The public portfolio is a Flutter Web app. It blocks its first paint on six RPCs to a Render free-tier server that sleeps, so recruiters and hiring managers wait 50+ seconds looking at a loader. Because the page renders to a canvas, search engines and link previews see almost nothing. On top of that, every content-writing endpoint (`create*`, `getUploadUrl`) is publicly callable without authentication. Rebuilding the site as a statically generated Jaspr (Dart) site fixes load time and SEO in one move, and it's a good moment to reshape the content into a recruiter-focused narrative and close the open write endpoints.

## What Changes

- **New `myfolio_web` package**: a Jaspr site in static (SSG) mode that outputs plain HTML/CSS per page. It is written in Dart with a Flutter-like component API and reuses `myfolio_client` models.
- **Build-time content**: during CI, the site pulls all portfolio content from the Serverpod API once and bakes it into the HTML. Visitors never call the Render server, so cold starts no longer affect them.
- **Recruiter-focused, single-scroll layout** replacing the tab UI: a hero with positioning and CTAs (resume, contact), an impact metrics strip, project case studies with images, an experience timeline, grouped skills, education, a "How this site is built" architecture section, and a contact section.
- **SEO and sharing**: per-page `<title>`, meta description, canonical URL, Open Graph/Twitter cards with a share image, JSON-LD `Person` structured data, `sitemap.xml`, `robots.txt`, and correct favicon/manifest metadata.
- **Publishing pipeline**: the GitHub Pages deploy workflow builds `myfolio_web` instead of `myfolio_flutter`. It runs on push, on manual dispatch, and on a daily schedule so DB content edits go live without a code change. If content can't be fetched, the build fails and the last good deploy stays live.
- **BREAKING (API)**: remove the public seeding methods (`portfolio.createRoles/createProjects/createSkills/createExperiences/createEducations`, `user.createUser`) and `file.getUploadUrl` from the public API. Seeding moves to a server-side command that is never exposed over RPC.
- **BREAKING (API)**: `User.phoneNumber` is no longer returned by the public API (it becomes server-only).
- **BREAKING (repo)**: **Remove the Flutter web app** (`myfolio_flutter`). It is no longer built or deployed; the Jaspr site replaces it. (Originally scoped as "keep but don't deploy"; the owner chose to delete it during implementation.)

## Capabilities

### New Capabilities
- `portfolio-site`: the public portfolio website. Covers the sections, content shown to visitors, rendering without a runtime backend dependency, responsiveness, theming, accessibility, and SEO/sharing metadata.
- `portfolio-content-api`: the Serverpod API that exposes portfolio content. Covers read-only public access, keeping write/seed operations off the public surface, and which personal fields are publicly visible.
- `site-publishing`: how the site is built and deployed. Covers build-time content fetching, rebuild triggers, failure behavior, and hosting.

### Modified Capabilities
<!-- None: no specs exist yet in openspec/specs/. -->

## Impact

- **New package**: `myfolio_web/` (Jaspr, `jaspr_cli`), depends on `myfolio_client`.
- **Server**: `myfolio_server/lib/src/endpoints/{portfolio,user,file}_endpoint.dart`, the `users` model (`phoneNumber` scope), the new seed entry point under `myfolio_server/bin/`, integration tests, and the regenerated `myfolio_client`.
- **Flutter app**: `myfolio_flutter/lib/providers/user_provider.dart` and `lib/screens/desktop_layout.dart` lose calls to the removed endpoints. The uncommitted change that wires "Download resume" to the seeders is discarded.
- **CI/CD**: `.github/workflows/deploy.yml` is rewritten. `analyze.yml` and `format.yml` gain `myfolio_web`.
- **Hosting**: still GitHub Pages under `/my_folio/`. Render + Neon remain as the content source and are only hit at build time.
- **Docs**: README updated for the new package, the build/deploy flow, and seeding.
- **Out of scope**: a server-backed contact form, richer models (experience highlights, case-study fields), a custom domain, and analytics. These are follow-up changes.
