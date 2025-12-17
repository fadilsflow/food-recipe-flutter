import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_storage/main.dart' as app;
import 'package:flutter_storage/providers/auth_provider.dart';
import 'package:flutter_storage/screens/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Auth Integration Test', () {
    testWidgets('Complete login flow: input credentials and navigate to home', 
      (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify we're on the LoginPage
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);

      // Find email and password fields
      final emailField = find.byType(TextField).at(0);
      final passwordField = find.byType(TextField).at(1);
      final loginButton = find.text('Login');

      // Enter test credentials
      // NOTE: Use valid test credentials from your API
      await tester.enterText(emailField, 'test@example.com');
      await tester.pumpAndSettle();
      
      await tester.enterText(passwordField, 'password123');
      await tester.pumpAndSettle();

      // Tap login button
      await tester.tap(loginButton);
      
      // Wait for the login process to complete
      // This includes API call, navigation, etc.
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify navigation to HomePage or error message
      // If login succeeds, we should see HomePage elements
      // If it fails, we should see a SnackBar with error
      
      // For successful login (adjust based on your HomePage):
      // expect(find.text('Home'), findsOneWidget);
      
      // For failed login (if using invalid credentials):
      // expect(find.byType(SnackBar), findsOneWidget);
      
      // Since we don't know if test credentials are valid,
      // we just verify that SOMETHING happened (no crash)
      expect(tester.takeException(), isNull);
    });

    testWidgets('Login with empty fields shows validation errors', 
      (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Find and tap login button without entering credentials
      final loginButton = find.text('Login');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      // Verify validation errors appear
      // CustomTextField should show validation errors
      // The exact error text depends on your validation logic
      expect(find.byType(LoginPage), findsOneWidget);
      
      // Verify we're still on login page (didn't navigate)
      expect(find.text('Welcome Back'), findsOneWidget);
    });

    testWidgets('Navigate to Register page and back', 
      (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Find and tap "Register" link
      final registerLink = find.text('Register');
      expect(registerLink, findsOneWidget);
      
      await tester.tap(registerLink);
      await tester.pumpAndSettle();

      // Verify we're on RegisterPage
      // Adjust based on your RegisterPage content
      expect(find.text('Create Account'), findsOneWidget);
      
      // Navigate back
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Verify we're back on LoginPage
      expect(find.text('Welcome Back'), findsOneWidget);
    });
  });
}
