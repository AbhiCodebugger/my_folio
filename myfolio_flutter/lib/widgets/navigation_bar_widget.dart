import 'package:flutter/material.dart';
import 'package:myfolio_flutter/models/tabs.dart';
import 'package:myfolio_flutter/providers/user_provider.dart';
import 'package:myfolio_flutter/utils/app_colors.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:myfolio_flutter/utils/responsive.dart';
import 'package:provider/provider.dart';

class TabsWidget extends StatelessWidget {
  TabsWidget({super.key});

  final List<Tabs> tabs = [
    Tabs(name: 'Home', icon: Icons.home),
    Tabs(name: 'Resume', icon: Icons.article),
    Tabs(name: 'Work', icon: Icons.work_outline_rounded),
    Tabs(name: 'Contact', icon: Icons.call),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Consumer<UserProvider>(
        builder: (context, provider, _) {
          return Row(
            mainAxisAlignment: context.isSmallScreen
                ? MainAxisAlignment.spaceAround
                : MainAxisAlignment.end,
            mainAxisSize: context.screenWidth < 800
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: tabs.asMap().entries.map((tab) {
              return GestureDetector(
                onTap: () {
                  provider.selectTab(tab.key);
                },
                child: AnimatedContainer(
                  height: context.hp(8),
                  width: context.isMobile ? context.wp(16) : context.wp(12),
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(context.hp(0.6)),
                  margin: EdgeInsets.all(context.hp(0.8)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: const [0.0, 1.0],
                      colors: provider.selectedTabIndex == tab.key
                          ? [
                              AppColors.kPrimaryColor,
                              AppColors.kSecondaryColor,
                            ]
                          : [
                              colorScheme.surfaceContainerHighest,
                              colorScheme.surfaceContainerHighest,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(context.hp(1.4)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        tab.value.icon,
                        color: provider.selectedTabIndex == tab.key
                            ? Colors.white
                            : colorScheme.primary,
                      ),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: AppTextStyle().small(
                          color: provider.selectedTabIndex == tab.key
                              ? Colors.white
                              : colorScheme.onSurface,
                        ),
                        child: Text(
                          tab.value.name,
                          style: AppTextStyle().small(
                            color: provider.selectedTabIndex == tab.key
                                ? Colors.white
                                : colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
