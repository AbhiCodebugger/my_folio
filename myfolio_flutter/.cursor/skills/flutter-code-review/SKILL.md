---
name: flutter-code-review
description: Flutter-specific code review checklist for shipperbee_delivery. Use when reviewing pull requests, code changes, or when the user asks for a code review.
---

# Flutter Code Review

## Project Conventions
- Provider + GetIt for DI; follow existing patterns
- Hive for local storage; use HiveDb singleton and HiveConstants
- Dio for REST; Repositories abstract API calls
- Use `logging` package, not print

## Checklist
- [ ] Code follows dart-standards (80-char lines, naming, null safety)
- [ ] Widgets use const where possible; ListView.builder for long lists
- [ ] No network/heavy work in build()
- [ ] Error handling present; no silent failures
- [ ] JSON models use json_serializable with fieldRename: snake
- [ ] No exposed secrets or API keys
- [ ] Accessibility: Semantics labels where needed; contrast 4.5:1
- [ ] Tests cover changes where appropriate

## Feedback Format
- **Critical**: Must fix before merge
- **Suggestion**: Consider improving
- **Nice to have**: Optional enhancement

Provide specific examples of how to fix issues.
