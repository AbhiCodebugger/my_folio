# Enterprise Scale

Patterns for when a Flutter app outgrows a single `lib/` tree. Based on
LeanCode's feature-based architecture at scale
(https://leancode.co/blog/feature-based-flutter-architecture).

## When features become packages

Promote a feature to its own package when:

- Multiple apps or flavors need the same feature with different shells
- A team owns the feature independently with its own release cadence
- The feature has a stable public API (entrypoint widget + models) and hidden internals
- Build times suffer because unrelated features rebuild together

```
packages/
├── comment_section/     # feature package
├── user_profile/
apps/
└── myfolio_flutter/     # composes packages, owns routing & DI root
```

Each package exposes a **single entrypoint widget** and typed models. Internal
`bloc/`, `widgets/`, and data code stay private to the package.

## Cross-feature communication

Features must not import each other's internals. Options, in order of preference:

1. **Promote to shared code** — move the widget/model to `lib/common/` or a
   `design_system` package when two features need the same thing.
2. **Navigate with data** — pass IDs or lightweight DTOs through the router;
   the destination feature fetches its own data.
3. **App-level coordinator** — a thin orchestrator above features (e.g.
   auth session changes trigger portfolio refresh) lives in the app shell, not
   inside either feature.
4. **Event bus (last resort)** — use only for truly decoupled side effects
   (analytics, snackbars). Prefer typed streams over stringly-typed globals.

## Global vs feature-scoped DI

- **App root**: `ApiClient`, auth session, theme, analytics — few providers only.
- **Feature entrypoint**: cubits/view models, feature-scoped repositories.
- Avoid deep global `MultiProvider` trees; they risk stack overflow on very
  large apps (Flutter issue #85026). Push providers down into feature subtrees.

## Backend-for-frontend at scale

Prefer one typed endpoint per screen (`GetCommentSection`) over generic REST
that over-fetches. Serverpod-generated clients fit this model — keep endpoint
calls in the data layer or cubit, not in views.

## Testing at scale

- **Unit**: cubits/view models and repositories — no `BuildContext`, no widget tree.
- **Widget**: entrypoint widgets and design-system components.
- **Integration**: critical user journeys per feature; run in CI per package when split.

## What stays in the app shell

Routing, flavor config, global error handling, monitoring, localization, and
CI entry points belong in the app package — not inside feature packages.
