# site-publishing Specification

## Purpose

Defines how the public portfolio site is built from API content and published to static hosting, including when rebuilds happen and what happens when content can't be fetched.

## Requirements


### Requirement: Build-time content snapshot
The site build SHALL fetch all portfolio content from the portfolio API once, before rendering, and embed it into the generated pages. The build MUST tolerate a sleeping API by retrying for at least 3 minutes before giving up.

#### Scenario: API cold start during build
- **WHEN** the build starts while the API server is asleep and the server responds after 60 seconds
- **THEN** the build waits, fetches the content, and completes successfully

### Requirement: Fail closed on content errors
If content can't be fetched, or required content is missing (no profile), the build SHALL fail without publishing. The previously published site MUST remain live and unchanged.

#### Scenario: API unreachable
- **WHEN** the API is unreachable for the whole retry window
- **THEN** the build job fails and the live site still serves the last successful deployment

#### Scenario: Empty profile
- **WHEN** the API returns no profile
- **THEN** the build job fails with an error stating that profile content is missing

### Requirement: Rebuild triggers
The site SHALL be rebuilt and published on every push to `main`, on manual dispatch, and on a daily schedule, so content changed in the database goes live within 24 hours without a code change.

#### Scenario: Content edited in the database
- **WHEN** the operator updates a project description in the database and makes no code change
- **THEN** the change appears on the live site after the next scheduled build or a manual dispatch

### Requirement: Static hosting
The published output SHALL consist only of static files (HTML, CSS, JS, images, fonts, metadata files) served from GitHub Pages under the `/my_folio/` base path, with all internal links and asset URLs resolving under that base path.

#### Scenario: Asset paths
- **WHEN** the site is served at `https://abhicodebugger.github.io/my_folio/`
- **THEN** every stylesheet, script, image, and internal link loads without a 404

### Requirement: Single website deployment
Only the static portfolio site SHALL be deployed to GitHub Pages. The Flutter web app MUST NOT be built or published by the deploy workflow.

#### Scenario: Deploy run
- **WHEN** the deploy workflow runs
- **THEN** the published artifact contains the static site output and no Flutter web build
