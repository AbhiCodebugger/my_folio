import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:myfolio_flutter/utils/responsive.dart';

String linkedIn = 'assets/icons/linkedin.png';
String github = 'assets/icons/github.png';
String stack = 'assets/icons/stack.png';
String defaultResumeUrl =
    'https://drive.google.com/file/d/1qIpPreb7mEQfptQi-XaRr_zyQcOx5str/view?usp=drive_link';

Color getColorForSkill(String title) {
  switch (title) {
    case "App Development":
      return Colors.orange.withValues(alpha: 0.1);
    case "Backend Development":
      return Colors.blue.withValues(alpha: 0.1);
    case "UI/UX Design":
      return Colors.green.withValues(alpha: 0.1);
    default:
      return Colors.purple.withValues(alpha: 0.1);
  }
}

Icon getIconForSkill(String title) {
  switch (title) {
    case "Mobile Engineering":
      return Icon(
        Icons.phone_android_rounded,
        color: Colors.orange,
        size: 40,
      );
    case "AI-Augmented Development":
      return Icon(Icons.webhook_outlined, color: Colors.blue, size: 40);
    case "Backend & System Design":
      return Icon(
        Icons.web,
        color: Colors.green,
        size: 40,
      );
    case "UI/UX & Design Systems":
      return Icon(
        Icons.design_services_outlined,
        color: Colors.teal,
        size: 40,
      );
    default:
      return Icon(
        Icons.rocket_launch_rounded,
        color: Colors.purple,
        size: 40,
      );
  }
}

Row buildHeading(BuildContext context, String title) {
  final colorScheme = Theme.of(context).colorScheme;
  return Row(
    children: [
      Text(
        title.toUpperCase(),
        style: AppTextStyle().heading(
          color: colorScheme.onSurface,
          letterSpacing: 2.0,
        ),
      ),
      Gap(context.wp(2)),
      Container(
        height: context.hp(0.2),
        width: context.wp(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.0],
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
            ],
          ),
        ),
      ),
    ],
  );
}
