import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfolio_flutter/utils/constants.dart';

void main() {
  group('getColorForSkill', () {
    test('returns a distinct color for each known category', () {
      final app = getColorForSkill('App Development');
      final backend = getColorForSkill('Backend Development');
      final design = getColorForSkill('UI/UX Design');

      expect(app, isNot(equals(backend)));
      expect(backend, isNot(equals(design)));
    });

    test('falls back to the default color for unknown titles', () {
      final unknown = getColorForSkill('Something Else');
      expect(unknown, Colors.purple.withValues(alpha: 0.1));
    });
  });

  group('getIconForSkill', () {
    test('maps known roles to specific icons', () {
      expect(
        getIconForSkill('Mobile Engineering').icon,
        Icons.phone_android_rounded,
      );
      expect(
        getIconForSkill('AI-Augmented Development').icon,
        Icons.webhook_outlined,
      );
      expect(getIconForSkill('Backend & System Design').icon, Icons.web);
    });

    test('falls back to the rocket icon for unknown roles', () {
      expect(getIconForSkill('Unknown Role').icon, Icons.rocket_launch_rounded);
    });
  });
}
