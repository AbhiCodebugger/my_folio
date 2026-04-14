import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:myfolio_client/myfolio_client.dart';
import 'package:myfolio_flutter/utils/app_colors.dart';
import 'package:myfolio_flutter/utils/app_textstyle.dart';
import 'package:myfolio_flutter/utils/constants.dart';
import 'package:myfolio_flutter/utils/responsive.dart';
import 'package:myfolio_flutter/widgets/rounded_gradient_button.dart';

class ProfileOverView extends StatelessWidget {
  final User? user;
  final VoidCallback? onDownload;

  const ProfileOverView({
    super.key,
    this.user,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("User in Profile Overview: ${user?.name}");
    return ResponsiveLayoutBuilder(
      mobile: (context) => _buildContent(context, isCompact: true),
      tablet: (context) => _buildContent(context, isCompact: false),
      desktop: (context) => _buildContent(context, isCompact: false),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isCompact}) {
    // Dynamic values based on component size
    final double padding = isCompact ? 16.0 : 24.0;
    final double imageSize = isCompact ? 110.0 : 140.0;
    final double socialSize = isCompact ? 20.0 : 24.0;

    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      // Use responsive spacing for consistent margins
      height: context.isMobile ? context.hp(75) : context.hp(70),
      padding: EdgeInsets.only(
        top: padding,
        left: padding,
        right: padding,
        bottom: 0,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: isCompact ? 8 : 12,
              bottom: isCompact ? 20 : 30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Picture
                Container(
                  height: imageSize,
                  width: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/profile_pic.jpg",
                      // fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: Icon(Icons.person, size: imageSize * 0.6),
                        );
                      },
                    ),
                  ),
                ),
                Gap(isCompact ? 12 : 16),
                Text(
                  user?.name ?? '',
                  style: AppTextStyle()
                      .heading(color: colorScheme.onSurface, letterSpacing: 2.0)
                      .copyWith(
                        fontSize: isCompact
                            ? 18
                            : null, // Adjust font size if compact
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(isCompact ? 6 : 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    user?.title ?? '',
                    style: AppTextStyle()
                        .medium(
                          color: colorScheme.onInverseSurface,
                          letterSpacing: 1.5,
                        )
                        .copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isCompact ? 10 : 12,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gap(isCompact ? 16 : 20),
                // Social Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      (user?.socialUrls ?? [])
                          .map(
                            (social) => Container(
                              padding: EdgeInsets.all(isCompact ? 6 : 8),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                _getSocialIconPath(
                                  user?.socialUrls.indexOf(social) ?? 0,
                                ),
                                height: socialSize,
                                width: socialSize,
                              ),
                            ),
                          )
                          .toList(),
                ),
                Gap(isCompact ? 16 : 20),
                // Contact Information
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 12 : 16,
                    vertical: isCompact ? 8 : 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildContactTile(
                        context: context,
                        icon: Icons.phone_android_rounded,
                        title: 'Phone'.toUpperCase(),
                        subtitle: user?.phoneNumber ?? '',
                        isCompact: isCompact,
                      ),
                      Divider(color: colorScheme.outline.withValues(alpha: 0.5)),
                      _buildContactTile(
                        context: context,
                        icon: Icons.email,
                        title: 'Email'.toUpperCase(),
                        subtitle: user?.email ?? '',
                        isCompact: isCompact,
                      ),
                      Divider(color: colorScheme.outline.withValues(alpha: 0.5)),
                      _buildContactTile(
                        context: context,
                        icon: Icons.location_on_outlined,
                        title: 'Location'.toUpperCase(),
                        subtitle: user?.location ?? '',
                        isCompact: isCompact,
                      ),
                    ],
                  ),
                ),
                Gap(isCompact ? 36 : 24),
                // Resume Button
                // Resume Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButtonWidget(
                      buttonText: 'Download Resume',
                      // width: isCompact ? 100 : 220,
                      width: 220,
                      // onpressed: () => launchUrl(
                      //   Uri.parse(user?.resumeUrl ?? ''),
                      //   mode: LaunchMode.externalApplication,
                      // ),
                      onpressed: () => onDownload?.call(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Divider(
        height: 1,
        color: colorScheme.outlineVariant.withValues(alpha: 0.2),
      ),
    );
  }

  String _getSocialIconPath(int index) {
    switch (index) {
      case 0:
        return linkedIn;
      case 1:
        return github;
      case 2:
        return stack;
      default:
        return 'assets/icons/default.png';
    }
  }

  Widget _buildContactTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompact,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Card(
        color: colorScheme.surface,
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: AppColors.kSecondaryColor,
            size: isCompact ? 16 : 18,
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTextStyle()
            .smallBold(
              color: AppColors.kSecondaryColor,
            )
            .copyWith(fontSize: isCompact ? 8 : 9),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyle().smallBold(color: colorScheme.onSurface),
      ),
    );
  }
}
