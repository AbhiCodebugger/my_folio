import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();
  static final AppTextStyle _instance = AppTextStyle._();
  factory AppTextStyle() => _instance;

  static const String _fontFamily = 'Optima';

  TextStyle get _baseTextStyle => const TextStyle(
    fontFamily: _fontFamily,
    color: Colors.black,
  );

  TextStyle heading({Color? color, double? letterSpacing}) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: 20,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle subHeading({Color? color, double? letterSpacing}) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: 15,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle medium({Color? color, double? letterSpacing}) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: 14,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle mediumBold({Color? color, double? letterSpacing}) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: 14,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle small({
    Color? color,
    double? letterSpacing,
  }) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: 12,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle smallBold({Color? color, double? letterSpacing}) {
    return _baseTextStyle.copyWith(
      color: color,
      fontSize: 12,
      letterSpacing: letterSpacing,
      fontWeight: FontWeight.bold,
    );
  }
}
