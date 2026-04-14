import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
/// Best practice for consistent responsive design across the app
class Responsive {
  // Private constructor to prevent instantiation
  Responsive._();

  // Breakpoint constants
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Check if current screen is mobile
  /// [width] is optional. If provided, it checks against that specific width (for component-level responsiveness).
  /// If null, it checks against the full screen width.
  static bool isMobile(BuildContext context, {double? width}) {
    final w = width ?? MediaQuery.of(context).size.width;
    return w < mobileBreakpoint;
  }

  /// Check if current screen is tablet
  static bool isTablet(BuildContext context, {double? width}) {
    final w = width ?? MediaQuery.of(context).size.width;
    return w >= mobileBreakpoint && w < tabletBreakpoint;
  }

  /// Check if current screen is desktop
  static bool isDesktop(BuildContext context, {double? width}) {
    final w = width ?? MediaQuery.of(context).size.width;
    return w >= tabletBreakpoint;
  }

  /// Check if screen is small (mobile or tablet)
  static bool isSmallScreen(BuildContext context, {double? width}) {
    final w = width ?? MediaQuery.of(context).size.width;
    return w < tabletBreakpoint;
  }

  /// Get screen width
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Get screen height
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Get responsive value based on screen size
  /// Usage: Responsive.value(context, mobile: 12, tablet: 16, desktop: 20)
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
    double? width,
  }) {
    if (isDesktop(context, width: width) && desktop != null) return desktop;
    if (isTablet(context, width: width) && tablet != null) return tablet;
    return mobile;
  }

  /// Get percentage of screen width
  /// Usage: Responsive.wp(context, 50) // 50% of screen width
  static double wp(BuildContext context, double percentage) =>
      width(context) * (percentage / 100);

  /// Get percentage of screen height
  /// Usage: Responsive.hp(context, 10) // 10% of screen height
  static double hp(BuildContext context, double percentage) =>
      height(context) * (percentage / 100);

  /// Get responsive font size
  /// Automatically scales based on screen width
  static double fontSize(BuildContext context, double baseSize) {
    final screenWidth = width(context);
    if (screenWidth < mobileBreakpoint) {
      return baseSize * 0.9; // 90% on mobile
    } else if (screenWidth < tabletBreakpoint) {
      return baseSize; // 100% on tablet
    } else {
      return baseSize * 1.1; // 110% on desktop
    }
  }

  /// Get responsive spacing
  /// Returns smaller spacing on mobile, larger on desktop
  static double spacing(
    BuildContext context, {
    double mobile = 8.0,
    double? tablet,
    double? desktop,
  }) {
    return value(
      context: context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2,
    );
  }
}

/// Extension on BuildContext for easier responsive access
/// Usage: context.isMobile
extension ResponsiveContext on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  bool get isSmallScreen => Responsive.isSmallScreen(this);

  double get screenWidth => Responsive.width(this);
  double get screenHeight => Responsive.height(this);

  /// Get percentage of screen width
  double wp(double percentage) => Responsive.wp(this, percentage);

  /// Get percentage of screen height
  double hp(double percentage) => Responsive.hp(this, percentage);

  /// Get responsive value
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) => Responsive.value(
    context: this,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}

/// Responsive widget builder (Screen-level)
/// Builds different widgets based on screen size using MediaQuery
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context) && desktop != null) {
      return desktop!;
    }
    if (Responsive.isTablet(context) && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

/// Responsive layout builder (Component-level)
/// Uses LayoutBuilder to determine size available to this specific widget
class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) mobile;
  final Widget Function(BuildContext context)? tablet;
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (Responsive.isDesktop(context, width: width) && desktop != null) {
          return desktop!(context);
        }
        if (Responsive.isTablet(context, width: width) && tablet != null) {
          return tablet!(context);
        }
        return mobile(context);
      },
    );
  }
}

/// Responsive visibility widget
/// Shows/hides widget based on screen size
class ResponsiveVisibility extends StatelessWidget {
  final Widget child;
  final bool visibleOnMobile;
  final bool visibleOnTablet;
  final bool visibleOnDesktop;

  const ResponsiveVisibility({
    super.key,
    required this.child,
    this.visibleOnMobile = true,
    this.visibleOnTablet = true,
    this.visibleOnDesktop = true,
  });

  @override
  Widget build(BuildContext context) {
    bool shouldShow = false;

    if (Responsive.isMobile(context) && visibleOnMobile) {
      shouldShow = true;
    } else if (Responsive.isTablet(context) && visibleOnTablet) {
      shouldShow = true;
    } else if (Responsive.isDesktop(context) && visibleOnDesktop) {
      shouldShow = true;
    }

    return shouldShow ? child : const SizedBox.shrink();
  }
}
