import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static AppColors appColors = AppColors._();
  factory AppColors() => appColors;

  static Color kPrimaryColor = const Color.fromARGB(255, 14, 98, 209);
  static Color kSecondaryColor = const Color(0xFF537B99);
  static Color kGreylightColor = Colors.grey.shade100;
  static Color kOrangelightColor = const Color.fromARGB(255, 255, 240, 224);
  static Color kSecondaryLightColor = const Color.fromARGB(255, 240, 248, 255);
}
