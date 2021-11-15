import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rapid_reps/main.dart';
import 'package:rapid_reps/screens/export.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group(
    'Login Screen: ',
    () {
      testWidgets(
        'When the app loads, the Login Page is displayed',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MyApp(),
          );

          expect(
            find.byType(LoginScreen),
            findsOneWidget,
          );
        },
      );

      testWidgets(
          'When Sign Up Button is clicked, user is redirected to Sign Up Page',
          (WidgetTester tester) async {
        final mockObserver = MockNavigatorObserver();
        await tester.pumpWidget(
          MaterialApp(
            home: const LoginScreen(),
            navigatorObservers: [mockObserver],
          ),
        );

        await tester.tap(
          find.text('Sign Up'),
        );
        await tester.pumpAndSettle();

        expect(find.byType(InitialSignUpScreen), findsOneWidget);
      });
    },
  );
}
