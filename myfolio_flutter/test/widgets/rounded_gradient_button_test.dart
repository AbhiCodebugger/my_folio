import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfolio_flutter/widgets/rounded_gradient_button.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('RoundedButtonWidget', () {
    testWidgets('renders the provided label and a download icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          RoundedButtonWidget(
            buttonText: 'Download CV',
            width: 200,
            onpressed: () {},
          ),
        ),
      );

      expect(find.text('Download CV'), findsOneWidget);
      expect(find.byIcon(Icons.download), findsOneWidget);
    });

    testWidgets('invokes onpressed when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          RoundedButtonWidget(
            buttonText: 'Download CV',
            width: 200,
            onpressed: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
