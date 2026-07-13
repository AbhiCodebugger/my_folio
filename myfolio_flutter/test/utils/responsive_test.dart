import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfolio_flutter/utils/responsive.dart';

Future<BuildContext> _contextForWidth(WidgetTester tester, double width) async {
  late BuildContext captured;
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: Builder(
        builder: (context) {
          captured = context;
          return const SizedBox();
        },
      ),
    ),
  );
  return captured;
}

void main() {
  group('Responsive breakpoints', () {
    testWidgets('classifies a narrow width as mobile', (tester) async {
      final context = await _contextForWidth(tester, 400);
      expect(Responsive.isMobile(context), isTrue);
      expect(Responsive.isTablet(context), isFalse);
      expect(Responsive.isDesktop(context), isFalse);
    });

    testWidgets('classifies a mid width as tablet', (tester) async {
      final context = await _contextForWidth(tester, 800);
      expect(Responsive.isMobile(context), isFalse);
      expect(Responsive.isTablet(context), isTrue);
      expect(Responsive.isDesktop(context), isFalse);
    });

    testWidgets('classifies a wide width as desktop', (tester) async {
      final context = await _contextForWidth(tester, 1400);
      expect(Responsive.isDesktop(context), isTrue);
      expect(Responsive.isSmallScreen(context), isFalse);
    });

    testWidgets('value() picks the correct variant per size', (tester) async {
      final mobileCtx = await _contextForWidth(tester, 400);
      expect(
        Responsive.value(
          context: mobileCtx,
          mobile: 'm',
          tablet: 't',
          desktop: 'd',
        ),
        'm',
      );

      final desktopCtx = await _contextForWidth(tester, 1400);
      expect(
        Responsive.value(
          context: desktopCtx,
          mobile: 'm',
          tablet: 't',
          desktop: 'd',
        ),
        'd',
      );
    });
  });
}
