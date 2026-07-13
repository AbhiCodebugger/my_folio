import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfolio_flutter/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('defaults to light mode', () {
      final provider = ThemeProvider();
      expect(provider.themeMode, ThemeMode.light);
      expect(provider.isDarkMode, isFalse);
    });

    test('toggleTheme switches between light and dark', () {
      final provider = ThemeProvider();

      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.dark);
      expect(provider.isDarkMode, isTrue);

      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.light);
      expect(provider.isDarkMode, isFalse);
    });

    test('setThemeMode updates the mode', () {
      final provider = ThemeProvider();

      provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeMode, ThemeMode.dark);

      provider.setThemeMode(ThemeMode.system);
      expect(provider.themeMode, ThemeMode.system);
    });

    test('notifies listeners on change', () {
      final provider = ThemeProvider();
      var notifications = 0;
      provider.addListener(() => notifications++);

      provider.toggleTheme();
      provider.setThemeMode(ThemeMode.light);

      expect(notifications, 2);
    });
  });
}
