# Spec Delta

## Purpose

The public portfolio website that presents Abhinav's professional profile to hiring managers and recruiters, loads instantly, and can be read by search engines and link-preview crawlers.

## ADDED Requirements

### Requirement: Content renders without a runtime backend
Every page SHALL ship its full portfolio content as server-rendered HTML in the initial response. Visitors' browsers MUST NOT need to call the portfolio API to display any content.

#### Scenario: Backend asleep or down
- **WHEN** a visitor opens the site while the portfolio API is unreachable
- **THEN** the page shows all sections with full content and no loading or error overlay

#### Scenario: JavaScript disabled
- **WHEN** a visitor or crawler loads the home page with JavaScript disabled
- **THEN** the hero, metrics, projects, experience, skills, education, and contact sections are all present and readable in the HTML

### Requirement: Fast first render
The home page SHALL reach Largest Contentful Paint in under 2.5 seconds on a Lighthouse mobile run. Its Lighthouse Performance, SEO, Accessibility, and Best Practices scores MUST each be at least 90.

#### Scenario: Lighthouse audit
- **WHEN** Lighthouse (mobile preset) is run against the deployed home page
- **THEN** LCP is below 2.5 s and all four category scores are at least 90

### Requirement: Single-scroll recruiter narrative
The home page SHALL present all content on one scrollable page in this order: hero, impact metrics, projects, experience, skills, education, how this site is built, contact. A persistent navigation SHALL link to each section by anchor.

#### Scenario: Navigating to a section
- **WHEN** a visitor clicks "Experience" in the navigation
- **THEN** the page scrolls to the experience section and the URL fragment becomes `#experience`

#### Scenario: Deep link to a section
- **WHEN** a visitor opens the site URL ending in `#projects`
- **THEN** the page loads scrolled to the projects section

### Requirement: Hero with primary calls to action
The hero SHALL show the person's name, current title, a one-sentence positioning statement, location, profile photo, and social profile links. It SHALL show a "Download résumé" action and a "Contact me" action.

#### Scenario: Download résumé
- **WHEN** a visitor activates "Download résumé"
- **THEN** the résumé opens in a new tab from the published résumé URL

#### Scenario: Contact action
- **WHEN** a visitor activates "Contact me"
- **THEN** the page scrolls to the contact section

### Requirement: Impact metrics strip
The site SHALL display a short strip of quantified highlights directly below the hero, such as years of experience and scale figures from projects.

#### Scenario: Metrics visible above the fold on desktop
- **WHEN** the home page loads in a 1440x900 viewport
- **THEN** the metrics strip is at least partially visible without scrolling

### Requirement: Project case studies
Each active project SHALL be shown as a case study card with a title, an image, a description, and its tech stack as labels. A project with a project URL SHALL link to it, and a project without one MUST NOT show a broken or empty link.

#### Scenario: Project without a URL
- **WHEN** a project's URL is empty
- **THEN** its card shows no "View project" link

#### Scenario: Inactive project
- **WHEN** a project is marked inactive in the content source
- **THEN** it does not appear on the site

### Requirement: Experience timeline
Experience entries SHALL be shown as a reverse-chronological timeline with company, position, and duration, ordered by the content source's display order.

#### Scenario: Ordering
- **WHEN** the content source lists experiences with display orders 0..3
- **THEN** the timeline shows them in that order, most recent first

### Requirement: Skills and education
Skills SHALL be shown in their display order, and education entries SHALL be shown with institution, degree, field of study (when present), and duration.

#### Scenario: Missing field of study
- **WHEN** an education entry has an empty field of study
- **THEN** no empty separator or placeholder appears for it

### Requirement: How-this-site-is-built section
The site SHALL include a section describing its own architecture (static Dart site, Serverpod API, PostgreSQL, CI build-and-deploy), with a diagram, as a demonstration of engineering skill.

#### Scenario: Section present
- **WHEN** a visitor scrolls past education
- **THEN** an architecture section with a diagram and a short description of the stack is shown

### Requirement: Contact section
The contact section SHALL offer the public email as a `mailto:` link and links to the social profiles. It MUST NOT show a phone number.

#### Scenario: Email link
- **WHEN** a visitor activates the email link
- **THEN** the visitor's mail client opens with the portfolio email as the recipient

### Requirement: Responsive layout
The site SHALL lay out without horizontal scrolling at viewport widths from 320 px upward and SHALL adapt its layout for mobile (<600 px), tablet (600-1023 px), and desktop (>=1024 px).

#### Scenario: Small phone
- **WHEN** the site is viewed at 320 px wide
- **THEN** no content overflows horizontally and the navigation collapses into a compact menu

### Requirement: Light and dark theme
The site SHALL follow the visitor's OS color scheme by default and SHALL offer a toggle that overrides it. The choice SHALL persist across visits on the same browser.

#### Scenario: OS dark mode
- **WHEN** a first-time visitor's OS prefers dark mode
- **THEN** the site renders in the dark theme with no flash of the light theme

#### Scenario: Manual override persists
- **WHEN** a visitor switches to light theme and reloads the page
- **THEN** the site renders in the light theme

### Requirement: Accessible markup
The site SHALL use semantic landmarks and headings in a logical order, provide alt text for every content image, keep text contrast at WCAG AA or better in both themes, and make all interactive elements keyboard-reachable with a visible focus indicator.

#### Scenario: Keyboard navigation
- **WHEN** a visitor tabs through the page
- **THEN** every link and button receives a visible focus indicator in document order

### Requirement: Respect reduced motion
Scroll-reveal and other decorative animations MUST be disabled when the visitor's OS requests reduced motion.

#### Scenario: Reduced motion enabled
- **WHEN** the visitor's OS has "reduce motion" enabled
- **THEN** sections appear without animated transitions

### Requirement: Search and sharing metadata
Every page SHALL include a descriptive title, a meta description, a canonical URL, Open Graph and Twitter card tags with a share image, and JSON-LD `Person` structured data. The site SHALL publish `robots.txt` and `sitemap.xml`.

#### Scenario: Link preview
- **WHEN** the site URL is pasted into LinkedIn or Slack
- **THEN** the preview shows the person's name and title, the description, and the share image

#### Scenario: Crawler discovery
- **WHEN** a crawler requests `/my_folio/robots.txt`
- **THEN** it receives a robots file referencing the sitemap URL
