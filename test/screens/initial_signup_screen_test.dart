import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:rapid_reps/utilities/constants.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group(
    'Initial Sign Up Screen: ',
    () {
      testWidgets(
        'When CDO Button is clicked, user is redirected to the CDO agreement screen',
        (WidgetTester tester) async {
          final mockObserver = MockNavigatorObserver();
          await tester.pumpWidget(
            MaterialApp(
              home: const InitialSignUpScreen(),
              navigatorObservers: [mockObserver],
            ),
          );

          await tester.tap(
            find.text('CDO'),
          );
          await tester.pumpAndSettle();

          expect(
            find.byType(AgreemantScreen),
            findsOneWidget,
          );

          expect(
              (tester.firstWidget(find.byType(FloatingActionButton))
                      as FloatingActionButton)
                  .backgroundColor,
              kCDOColour);
        },
      );

      testWidgets(
        'When Solicitor Button is clicked, user is redirected to the Solicitor agreement screen',
        (WidgetTester tester) async {
          final mockObserver = MockNavigatorObserver();
          await tester.pumpWidget(
            MaterialApp(
              home: const InitialSignUpScreen(),
              navigatorObservers: [mockObserver],
            ),
          );

          await tester.tap(
            find.text('Solicitor'),
          );
          await tester.pumpAndSettle();

          expect(
            find.byType(AgreemantScreen),
            findsOneWidget,
          );

          expect(
              (tester.firstWidget(find.byType(FloatingActionButton))
                      as FloatingActionButton)
                  .backgroundColor,
              kSolicitorColour);
        },
      );

      testWidgets(
        'When Firm Rep Button is clicked, user is redirected to the Firm Rep agreement screen',
        (WidgetTester tester) async {
          final mockObserver = MockNavigatorObserver();
          await tester.pumpWidget(
            MaterialApp(
              home: const InitialSignUpScreen(),
              navigatorObservers: [mockObserver],
            ),
          );

          await tester.tap(
            find.text('Firm Representative'),
          );
          await tester.pumpAndSettle();

          expect(
            find.byType(AgreemantScreen),
            findsOneWidget,
          );

          expect(
              (tester.firstWidget(find.byType(FloatingActionButton))
                      as FloatingActionButton)
                  .backgroundColor,
              kFirmRepColour);
        },
      );
    },
  );
}
