# Spec Delta

## Purpose

The Serverpod API that serves portfolio content (profile, roles, projects, skills, experience, education, résumé link) to the site build. It is read-only to the public, and seeding and uploads stay off the public surface.

## ADDED Requirements

### Requirement: Public read-only content access
The API SHALL expose unauthenticated read operations for the profile, roles, active projects, skills, experiences, education, and résumé URL. List results SHALL be ordered by each entity's display order.

#### Scenario: Fetch skills
- **WHEN** an unauthenticated client requests skills
- **THEN** the API returns all skills ordered by display order

#### Scenario: Fetch projects
- **WHEN** an unauthenticated client requests projects
- **THEN** the API returns only active projects

### Requirement: No public write or seed operations
The public API MUST NOT expose any operation that inserts, updates, or deletes portfolio content, or that issues storage upload URLs.

#### Scenario: Attempt to call a removed seed method
- **WHEN** a client calls `portfolio.createRoles` or `user.createUser`
- **THEN** the server rejects the call as an unknown method and the database is unchanged

#### Scenario: Attempt to obtain an upload URL
- **WHEN** a client calls `file.getUploadUrl`
- **THEN** the server rejects the call as an unknown method and no upload URL is issued

### Requirement: Server-side seeding
Portfolio content SHALL be seedable only by an operator running a server-side command with database credentials. Seeding MUST be idempotent: running it against a database that already has content MUST NOT create duplicate rows.

#### Scenario: Seed an empty database
- **WHEN** the operator runs the seed command against an empty database
- **THEN** profile, roles, projects, skills, experiences, and education rows are created

#### Scenario: Re-run seeding
- **WHEN** the operator runs the seed command a second time
- **THEN** the row counts for every content table are unchanged

### Requirement: Public profile excludes phone number
The profile returned by the public API MUST NOT include the phone number. Name, title, summary, image path, social URLs, email, location, and résumé URL remain public.

#### Scenario: Fetch profile
- **WHEN** an unauthenticated client requests the profile
- **THEN** the response contains no phone number field
