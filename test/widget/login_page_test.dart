import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_storage/providers/auth_provider.dart';
import 'package:flutter_storage/screens/login_page.dart';

void main() {
  testWidgets('LoginPage Widget Test: UI elements are displayed', (
    WidgetTester tester,
  ) async {
    // Create a simple mock that doesn't do anything
    final mockAuthProvider = AuthProvider();

    // Build the LoginPage
    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>.value(
        value: mockAuthProvider,
        child: const MaterialApp(home: LoginPage()),
      ),
    );

    // Wait for animations
    await tester.pumpAndSettle();

    // Verify UI elements are present
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text("Don't have an account? "), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);

    // Verify form fields exist
    expect(find.byType(TextFormField), findsNWidgets(2));
  });

  testWidgets('LoginPage Widget Test: can enter text in fields', (
    WidgetTester tester,
  ) async {
    final mockAuthProvider = AuthProvider();

    await tester.pumpWidget(
      ChangeNotifierProvider<AuthProvider>.value(
        value: mockAuthProvider,
        child: const MaterialApp(home: LoginPage()),
      ),
    );

    await tester.pumpAndSettle();

    // Find the text fields
    final emailField = find.byType(TextFormField).at(0);
    final passwordField = find.byType(TextFormField).at(1);

    // Enter text
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');

    await tester.pump();

    // Verify text was entered (check controllers)
    final emailWidget = tester.widget<TextFormField>(emailField);
    final passwordWidget = tester.widget<TextFormField>(passwordField);

    expect(emailWidget.controller?.text, 'test@example.com');
    expect(passwordWidget.controller?.text, 'password123');
  });
}
