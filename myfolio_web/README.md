# myfolio_web

The public portfolio site: a statically generated [Jaspr](https://jaspr.site) (Dart) site published to GitHub Pages at <https://abhicodebugger.github.io/my_folio/>.

At build time, the site fetches all content once from the Serverpod API (`myfolio_server`) through the generated `myfolio_client`. It then pre-renders plain HTML, so visitors never call the API and never wait for the Render free tier to wake up.

## Prerequisites

- Dart SDK **3.10+**
- Jaspr CLI, pinned to match `pubspec.yaml`:

  ```bash
  dart pub global activate jaspr_cli 0.23.5
  ```

## Local development

```bash
cd myfolio_web
dart pub get
jaspr serve
```

Open <http://localhost:8080>. In dev the site is served from `/`; `jaspr build` (release) switches the base path to `/my_folio/` for GitHub Pages. Override either with `--dart-define=BASE_PATH=...`.

Content comes from production by default. To use a local server (see the root README for starting and seeding it), add `--dart-define=API_URL=http://localhost:8080/` and pass `--port 8085` to `jaspr serve`, so the two don't both use port 8080.

## Production build

```bash
jaspr build --dart-define=API_URL=https://my-folio-a91r.onrender.com
dart run tool/check_links.dart build/jaspr /my_folio/
```

Output goes to `build/jaspr/`. Because the build targets `/my_folio/`, opening `build/jaspr/index.html` directly from disk won't load images or scripts. To preview it, serve the folder under that path, e.g. `mkdir -p /tmp/site && ln -sfn "$PWD/build/jaspr" /tmp/site/my_folio && python3 -m http.server -d /tmp/site 8000`, then open <http://localhost:8000/my_folio/>. The build retries the API every 10 s for up to 3 minutes while it wakes up. If content still can't be fetched, or there is no profile, the build exits non-zero and nothing is published.

## Where things live

| What | Where |
|------|-------|
| Positioning line, meta description, metrics, project images, résumé fallback, architecture copy | `lib/content/site_config.dart` |
| Content snapshot and build-time loader (retries, fail-closed) | `lib/content/portfolio_content.dart` |
| Page sections | `lib/components/sections/` |
| Head metadata (title, OG/Twitter, JSON-LD), theme pre-paint and scroll-reveal scripts | `lib/components/seo_head.dart` |
| Interactive bits hydrated on the client (`@client`) | `lib/components/client/` (theme toggle, mobile nav) |
| Styles (inlined into `<head>`) | `lib/styles/site_css.dart` |
| Static files: images, font, OG image, `robots.txt`, `sitemap.xml` | `web/` |

Profile, roles, projects, skills, experience and education come from the database. To change them, edit the rows in Neon, then trigger the **Build and Deploy Portfolio Site** workflow (or wait for the daily run).

## Tests

```bash
dart test
```
