---
name: flutter-best-practices
description: >-
  Flutter architecture, feature structure, and Dart coding standards for
  my_folio. Use when writing or reviewing Dart/Flutter code, structuring
  features, deciding layer ownership, or applying line-level Dart habits.
---

# Flutter Best Practices

Concise entry point for Flutter/Dart conventions in this repo. Read the
reference that matches your task — do not load all of them unless needed.

## When to Use

- Designing or refactoring feature folder structure
- Deciding what belongs in views, view models, repositories, or services
- Writing or reviewing Dart code style, null safety, widgets, async, tests
- Scaling from a single app to multi-package or enterprise layout
- Complementing (not replacing) the focused skills: `architecture-feature-first`, `provider`, `flutter-errors`, `flutter-pre-caching`

## Quick Routing

| Task | Read |
|------|------|
| Layer responsibilities, dependency flow, MVVM rules | [architecture-layers.md](references/architecture-layers.md) |
| Feature folders, entrypoint widgets, cubit/state patterns | [feature-structure.md](references/feature-structure.md) |
| Null safety, collections, widgets, logging, linting | [dart-coding-practices.md](references/dart-coding-practices.md) |
| Multi-package apps, cross-feature communication | [enterprise-scale.md](references/enterprise-scale.md) |

## Project-Specific Context

For MyFolio stack (Serverpod client, Provider, flavors, layout), also read
the `myfolio-project-core` and `serverpod-api` skills.

## Workflow

1. **Pick the right reference** from the table above.
2. **Apply at the right level** — architecture decisions before line-level style.
3. **Match existing code** in `myfolio_flutter/lib/` when the reference allows multiple valid approaches.
4. **Prefer focused skills** when they cover the topic (`provider` for Provider setup, `flutter-errors` for layout failures).
