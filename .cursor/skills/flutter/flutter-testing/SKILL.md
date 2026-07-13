---
name: flutter-testing
description: >-
  Flutter and Dart testing patterns for my_folio. Use when writing or running
  unit, widget, or integration tests, or when asked about test coverage and
  mocks.
---

# Flutter Testing

## Running Tests

```bash
cd myfolio_flutter
flutter test                    # all tests
flutter test test/providers/    # single directory
```

Prefer the Dart MCP `run_tests` tool when available.

## Patterns

- **AAA**: Arrange → Act → Assert (Given → When → Then)
- **Unit**: providers, parsing, pure logic — no widget tree
- **Widget**: UI components; pump with `MaterialApp` + required `Provider`s
- **Integration**: end-to-end flows via `integration_test` (when added)

## MyFolio Notes

- `UserProvider` and `ThemeProvider` are `ChangeNotifier`s — test by calling
  methods and asserting getters / `notifyListeners` side effects
- Mock the global `client` sparingly; prefer injecting dependencies when
  refactoring for testability
- Environment tests live in `test/config/` — follow `Environment.initialize`
  patterns from `lib/config/environment.dart`

## Mocks

- Prefer fakes/stubs over mocks
- Use `mockito` or `mocktail` when mocks are needed
- Avoid codegen for mocks unless the fake would be unwieldy

## Assertions

- Use `flutter_test` matchers (`findsOneWidget`, `pumpAndSettle`)
- Prefer `package:checks` for assertions when available

## Coverage

- Add tests for new provider logic and non-trivial widgets
- Skip trivial getter-only or pure-const widget tests
