import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myfolio_flutter/providers/theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return IconButton(
          onPressed: () => themeProvider.toggleTheme(),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              key: ValueKey(themeProvider.themeMode),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          tooltip: themeProvider.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          ),
        );
      },
    );
  }
}
