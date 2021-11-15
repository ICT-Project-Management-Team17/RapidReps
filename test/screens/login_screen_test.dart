import 'package:flutter_test/flutter_test.dart';
import 'package:rapid_reps/main.dart';
import 'package:rapid_reps/screens/export.dart';

void main() {
  group('Login Screen: ', () {
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
  });
}
