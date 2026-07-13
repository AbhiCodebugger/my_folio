import 'package:flutter/material.dart';
import 'package:myfolio_flutter/providers/user_provider.dart';
import 'package:myfolio_flutter/screens/desktop_layout.dart';
import 'package:myfolio_flutter/screens/mobile_layout.dart';
import 'package:myfolio_flutter/screens/tablet_layout.dart';
import 'package:myfolio_flutter/utils/responsive.dart';
import 'package:myfolio_flutter/widgets/custom_loader.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<UserProvider>(
        builder: (context, vM, child) {
          final user = vM.user;
          final roles = vM.roles;
          final skills = vM.skills;
          final educations = vM.educations;
          final experiences = vM.experiences;

          return Stack(
            children: [
              ResponsiveBuilder(
                mobile: MobileLayout(
                  user: user,
                  roles: roles,
                  skills: skills,
                  educations: educations,
                  experiences: experiences,
                ),
                tablet: TabletLayout(
                  user: user,
                  roles: roles,
                  skills: skills,
                  educations: educations,
                  experiences: experiences,
                ),
                desktop: DesktopLayout(
                  user: user,
                  roles: roles,
                  skills: skills,
                  educations: educations,
                  experiences: experiences,
                ),
              ),
              if (vM.isLoading)
                CustomLoader(message: vM.loadingMessage),
              if (vM.loadFailed) _ConnectionErrorOverlay(onRetry: vM.retry),
            ],
          );
        },
      ),
    );
  }
}

class _ConnectionErrorOverlay extends StatelessWidget {
  const _ConnectionErrorOverlay({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud_off_outlined,
                  size: 48,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Could not reach server',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'The server may be waking up. Please try again.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => onRetry(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
