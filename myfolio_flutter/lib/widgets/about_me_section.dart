import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:myfolio_flutter/utils/constants.dart';
import 'package:myfolio_flutter/utils/custom/custom_container.dart';
import 'package:myfolio_flutter/utils/responsive.dart';

class AboutMeSection extends StatelessWidget {
  final User? user;
  final List<Roles>? roles;

  const AboutMeSection({super.key, this.roles, this.user});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      mobile: (context) =>
          _buildContent(context, user: user, roles: roles, isCompact: true),
      tablet: (context) =>
          _buildContent(context, user: user, roles: roles, isCompact: false),
      desktop: (context) =>
          _buildContent(context, user: user, roles: roles, isCompact: false),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required User? user,
    required List<Roles>? roles,
    required bool isCompact,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About Me Header
        buildHeading(context, 'About Me'),
        Gap(20),
        // About Me Description
        Text(
          user?.summary ?? '',
          textAlign: TextAlign.justify,
          maxLines: 4,
          style: AppTextStyle().medium(color: colorScheme.onSurface),
        ),
        Gap(20),
        // What I Do Header
        Text(
          'What I Do!',
          style: AppTextStyle().subHeading(color: colorScheme.onSurface),
        ),
        const Gap(30),
        // Skills Grid
        // Skills List
        Expanded(
          child: isCompact
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: roles?.length ?? 0,
                  separatorBuilder: (context, index) => const Gap(20),
                  itemBuilder: (context, index) {
                    final r = roles![index];
                    return CustomContainer(
                      title: r.title,
                      description: r.description,
                      kSecondaryColor: getColorForSkill(r.title),
                      icon: getIconForSkill(r.title),
                    );
                  },
                )
              : _buildTwoColumnList(roles ?? []),
        ),
      ],
    );
  }

  Widget _buildTwoColumnList(List<Roles> roles) {
    final rowCount = (roles.length / 2).ceil();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: rowCount,
      separatorBuilder: (_, __) => const Gap(20),
      itemBuilder: (context, rowIndex) {
        final left = rowIndex * 2;
        final right = left + 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomContainer(
                  title: roles[left].title,
                  description: roles[left].description,
                  kSecondaryColor: getColorForSkill(roles[left].title),
                  icon: getIconForSkill(roles[left].title),
                ),
              ),
              const Gap(20),
              if (right < roles.length)
                Expanded(
                  child: CustomContainer(
                    title: roles[right].title,
                    description: roles[right].description,
                    kSecondaryColor: getColorForSkill(roles[right].title),
                    icon: getIconForSkill(roles[right].title),
                  ),
                )
              else
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        );
      },
    );
  }
}
