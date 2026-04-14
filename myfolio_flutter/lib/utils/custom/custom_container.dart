import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.kSecondaryColor,
  });

  final String title;
  final String description;
  final Icon? icon;
  final Color? kSecondaryColor;

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: widget.kSecondaryColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: widget.icon,
        ),
        const Gap(20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: AppTextStyle().mediumBold(
                  color: colorScheme.onSurface,
                ),
              ),
              const Gap(8),
              AnimatedCrossFade(
                firstChild: Text(
                  widget.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle()
                      .small(color: colorScheme.onSurface)
                      .copyWith(height: 1.5),
                ),
                secondChild: Text(
                  widget.description,
                  style: AppTextStyle()
                      .small(color: colorScheme.onSurface)
                      .copyWith(height: 1.5),
                ),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
              const Gap(4),
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Text(
                  _expanded ? 'Show less' : 'Read more',
                  style: AppTextStyle()
                      .smallBold(color: colorScheme.primary)
                      .copyWith(fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
