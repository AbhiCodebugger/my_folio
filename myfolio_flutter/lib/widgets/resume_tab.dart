import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:myfolio_flutter/utils/constants.dart';
import 'package:myfolio_flutter/utils/custom/custom_colored_container.dart';
import 'package:myfolio_flutter/utils/responsive.dart';

class ResumeTab extends StatelessWidget {
  final List<Skill> skills;
  final List<Education> educations;
  final List<Experience> experiences;

  const ResumeTab({
    required this.skills,
    required this.educations,
    required this.experiences,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      children: [
        buildHeading(context, "Resume"),
        const Gap(20),
        isMobile
            ? _buildMobileLayout(context, colorScheme)
            : _buildDesktopLayout(context, colorScheme),
        const Gap(10),
        buildHeading(context, "Skills"),
        const Gap(10),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            skills.length,
            (index) => Chip(
              label: Text(
                skills[index].name,
                style: AppTextStyle().small(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, ColorScheme colorScheme) {
    return Column(
      children: [
        _buildEducationSection(context, colorScheme),
        const Gap(20),
        _buildExperienceSection(context, colorScheme),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: _buildEducationSection(context, colorScheme)),
        const Gap(10),
        Expanded(child: _buildExperienceSection(context, colorScheme)),
      ],
    );
  }

  Widget _buildEducationSection(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: colorScheme.primary),
              const Gap(10),
              Text(
                'Education',
                style: AppTextStyle().heading(color: colorScheme.onSurface),
              ),
            ],
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 200,
            child: ListView(
              children: [
                for (var education in educations)
                  CustomColoredContainer(
                    duration: education.duration,
                    role: education.institution,
                    description: education.degree,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.work, color: colorScheme.primary),
              const Gap(10),
              Text(
                'Experience',
                style: AppTextStyle().heading(color: colorScheme.onSurface),
              ),
            ],
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 200,
            child: ListView(
              children: [
                for (var experience in experiences)
                  CustomColoredContainer(
                    duration: experience.duration,
                    role: experience.company,
                    description: experience.position,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
