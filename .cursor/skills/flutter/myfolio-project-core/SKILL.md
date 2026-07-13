---
name: myfolio-project-core
description: >-
  Project context for my_folio: Serverpod Flutter client, Provider state,
  responsive layouts, flavors, and lib/ structure. Use when working anywhere
  in myfolio_flutter or when onboarding to this codebase.
---

# MyFolio — Project Core

## Overview

Personal portfolio app: Flutter frontend (`myfolio_flutter`) + Serverpod
backend (`myfolio_server`) + generated client (`myfolio_client`).

## Entry Points & Flavors

| File | Flavor | Use |
|------|--------|-----|
| `lib/main_dev.dart` | `Flavor.dev` | Local development |
| `lib/main.dart` | `Flavor.prod` | Production builds |

Both call `bootstrap(flavor)` in `lib/bootstrap.dart`, which:

1. Initializes `Environment` from `lib/config/environment.dart`
2. Resolves API URL (dev defaults to localhost; prod via `--dart-define=API_URL`)
3. Creates the global `Client` from `myfolio_client`
4. Wires `FlutterAuthSessionManager` and runs `MyApp`

## Architecture (current)

```
lib/
├── bootstrap.dart          # startup + global client
├── config/                 # environment / API URL
├── providers/              # ChangeNotifier (UserProvider, ThemeProvider)
├── screens/                # responsive shells (mobile/tablet/desktop)
├── widgets/                # tab content and shared UI
├── utils/                  # theme, responsive helpers, constants
└── models/                 # app-local models (e.g. tabs)
```

- **State**: `provider` — `ChangeNotifierProvider` at app root; see `provider` skill
- **API**: global `client` from `bootstrap.dart`; `UserProvider` calls `client.portfolio.*`, `client.user.*`, `client.file.*`
- **Auth**: Serverpod `client.auth` via `serverpod_auth_idp_flutter`
- **Responsive**: `utils/responsive.dart` + separate layout screens

## Key Conventions

- Use `logging` / structured logs, not `print`
- Prefer `const` constructors in `build()` where possible
- No network or heavy work in `build()`
- Generated models live in `myfolio_client` — do not hand-edit
- Assets: `assets/config.json`, `assets/icons/`, `assets/images/`

## Dev Commands

```bash
# Dev (Chrome)
flutter run -d Chrome -t lib/main_dev.dart

# Prod web
flutter build web --release -t lib/main.dart \
  --dart-define=API_URL=https://my-folio-a91r.onrender.com
```

## Related Skills

- `serverpod-api` — client usage and endpoint patterns
- `architecture-feature-first` — target structure when adding features
- `flutter-best-practices` — Dart/style references
- `flutter-testing` — test patterns for this project
