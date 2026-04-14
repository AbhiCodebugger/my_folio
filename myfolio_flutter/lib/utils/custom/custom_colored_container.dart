import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';

class CustomColoredContainer extends StatelessWidget {
  const CustomColoredContainer({
    super.key,
    required this.duration,
    required this.role,
    required this.description,
  });

  final String duration;
  final String role;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            duration,
            style: AppTextStyle().medium(color: Colors.blue),
          ),
          const Gap(6),
          Text(
            role,
            style: AppTextStyle().smallBold(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const Gap(6),
          Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle().small(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
