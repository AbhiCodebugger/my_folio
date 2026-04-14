import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/providers/user_provider.dart';
import 'package:myfolio_flutter/utils/responsive.dart';
import 'package:myfolio_flutter/widgets/about_me_section.dart';
import 'package:myfolio_flutter/widgets/navigation_bar_widget.dart';
import 'package:myfolio_flutter/widgets/profile_overview_widget.dart';
import 'package:myfolio_flutter/widgets/resume_tab.dart';
import 'package:myfolio_flutter/widgets/contact_tab.dart';
import 'package:myfolio_flutter/widgets/theme_toggle_button.dart';
import 'package:myfolio_flutter/widgets/work_tab.dart';
import 'package:provider/provider.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({
    super.key,
    required this.user,
    required this.roles,
    required this.skills,
    required this.educations,
    required this.experiences,
  });

  final User? user;
  final List<Roles> roles;
  final List<Skill> skills;
  final List<Education> educations;
  final List<Experience> experiences;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            flex: 2,
            child: ProfileOverView(user: user),
          ),
          const Gap(12),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const ThemeToggleButton(),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabsWidget(),
                  ],
                ),
                const Gap(10),
                Consumer<UserProvider>(
                  builder: (context, provider, _) {
                    Widget child;
                    switch (provider.selectedTabIndex) {
                      case 0:
                        child = AboutMeSection(
                          roles: roles,
                          user: user,
                        );
                        break;
                      case 1:
                        child = ResumeTab(
                          skills: skills,
                          educations: educations,
                          experiences: experiences,
                        );
                        break;
                      case 2:
                        child = WorkTab(
                          projects: provider.projects,
                        );
                        break;
                      case 3:
                        child = ContactTab(user: user);
                        break;
                      default:
                        child = AboutMeSection(
                          roles: roles,
                          user: user,
                        );
                    }
                    return Container(
                      height: context.hp(70),
                      padding: EdgeInsets.all(context.hp(2)),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.shadow.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: child,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
