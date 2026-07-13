---
name: flutter-code-review
description: >-
  Flutter-specific code review checklist for my_folio. Use when reviewing
  pull requests, code changes, or when the user asks for a code review.
---

# Flutter Code Review — MyFolio

## Project Conventions

- Provider for UI state; global `Client` from `bootstrap.dart` (see `myfolio-project-core`)
- Serverpod generated client — no hand-rolled JSON models
- Responsive layouts: mobile / tablet / desktop screens
- Use `logging`, not `print`

## Checklist

- [ ] Follows Dart style (80-char lines, naming, null safety) — see `flutter-best-practices`
- [ ] Widgets use `const` where possible; `ListView.builder` for long lists
- [ ] No network or heavy work in `build()`
- [ ] Error handling present; no silent failures in providers
- [ ] No exposed secrets or API keys in client code
- [ ] Generated `myfolio_client` models not hand-edited
- [ ] Provider usage matches `provider` skill (correct provider type, no unnecessary rebuilds)
- [ ] Tests cover non-trivial provider/widget changes

## Feedback Format

- **Critical**: Must fix before merge
- **Suggestion**: Consider improving
- **Nice to have**: Optional enhancement

Provide specific examples of how to fix issues.
