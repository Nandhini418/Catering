import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catering/main.dart';
import 'package:catering/login_sections/splash_screen.dart';
import 'package:catering/login_sections/login_screen.dart';
import 'package:catering/login_sections/register_screen.dart';

void main() {
  testWidgets('Splash screen transitions to Login screen after 3 seconds', (
    WidgetTester tester,
  ) async {
    // 1. Pump MyApp
    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreen), findsOneWidget);

    // 2. Advance time by 3 seconds
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // 3. Verify LoginScreen is displayed
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Send OTP'), findsOneWidget);

    // 4. Tap the Register button/link and verify RegisterScreen opens
    final registerFinder = find.byWidgetPredicate(
      (w) => w is RichText && w.text.toPlainText().contains('Register'),
    );
    expect(registerFinder, findsOneWidget);
    await tester.tap(registerFinder);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.text('Worker Registration'), findsOneWidget);
  });
}
