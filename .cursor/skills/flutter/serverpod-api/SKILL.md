---
name: serverpod-api
description: >-
  Serverpod client usage and API patterns for my_folio. Use when calling
  endpoints, working with generated models in myfolio_client, or handling
  auth and file uploads.
---

# Serverpod API — MyFolio

## Client Setup

The global `Client` is created in `lib/bootstrap.dart`:

```dart
client = Client(serverUrl)
  ..connectivityMonitor = FlutterConnectivityMonitor()
  ..authSessionManager = FlutterAuthSessionManager();
client.auth.initialize();
```

Import: `package:myfolio_client/myfolio_client.dart`

## Generated Models

- Defined on the server; generated into `myfolio_client`
- **Never hand-edit** generated files — change the Serverpod model/endpoint and regenerate
- Types used in the app: `User`, `Project`, `Skill`, `Roles`, `Experience`, `Education`, etc.

## Endpoint Usage (current patterns)

`UserProvider` is the primary consumer. Examples:

| Domain | Calls |
|--------|-------|
| User | `client.user.getUser()`, `client.user.createUser()` |
| Portfolio | `client.portfolio.getSkills()`, `getProjectList()`, `getRoles()`, `getExperiences()`, `getEducations()` |
| Seed data | `client.portfolio.createSkills()`, `createProjects()`, `createRoles()`, `createExperiences()`, `createEducations()` |
| Files | `client.file.getUploadUrl(...)`, `client.file.getResumeUrl()` |

## Guidelines

- Keep endpoint calls out of `build()` — use providers, view models, or `initState` / cubits
- Handle errors at the call site; surface user-visible failures via provider state
- Use `Future.wait` for parallel independent fetches (see `UserProvider.init`)
- Auth state: `client.auth` — check session before protected operations

## Adding New Endpoints

1. Define endpoint/model in `myfolio_server`
2. Run Serverpod code generation (`serverpod generate`)
3. Use the new method on `client` from a provider or repository
4. Add tests for the provider/repository layer

## Not Used in This Project

- Dio + hand-written `json_serializable` models — use generated Serverpod client instead
- Raw REST without the typed client
