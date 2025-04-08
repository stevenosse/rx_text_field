import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rx_text_field/rx_text_field.dart';

// Test model class for complex object testing
class TestUser {
  String username;
  String password;

  TestUser({this.username = '', this.password = ''});
}

void main() {
  group('RxTextField', () {
    testWidgets('should initialize with simple string model', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('initial text');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<String>(
              model: model,
              decoration: const InputDecoration(labelText: 'Test Field'),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('initial text'), findsOneWidget);
      expect(find.text('Test Field'), findsOneWidget);
    });

    testWidgets('should update text when model changes', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('initial text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<String>(
              model: model,
              decoration: const InputDecoration(labelText: 'Test Field'),
            ),
          ),
        ),
      );

      // Act
      model.updateField('updated text');
      await tester.pump();

      // Assert
      expect(find.text('updated text'), findsOneWidget);
    });

    testWidgets('should update model when text changes', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('initial text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<String>(
              model: model,
              decoration: const InputDecoration(labelText: 'Test Field'),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextField), 'user input');

      // Assert
      expect(model.data, equals('user input'));
    });

    testWidgets('should work with complex objects using field and onChanged', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<TestUser>(
        TestUser(username: 'user', password: 'pass'),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<TestUser>(
              model: model,
              decoration: const InputDecoration(labelText: 'Username'),
              field: (m) => m.username,
              onChanged: (m, value) => m.username = value,
            ),
          ),
        ),
      );

      // Assert initial state
      expect(find.text('user'), findsOneWidget);

      // Act - update through UI
      await tester.enterText(find.byType(TextField), 'newuser');

      // Assert model updated
      expect(model.data.username, equals('newuser'));
      expect(model.data.password, equals('pass')); // Password unchanged

      // Act - update through model
      model.data.username = 'changed';
      model.notifyListeners();
      await tester.pump();

      // Assert UI updated
      expect(find.text('changed'), findsOneWidget);
    });

    testWidgets('should obscure text when obscureText is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('password');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<String>(
              model: model,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ),
        ),
      );

      // Assert
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('should use custom decoration when provided', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('test');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<String>(
              model: model,
              decoration: const InputDecoration(
                labelText: 'Custom Label',
                hintText: 'Custom Hint',
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('Custom Label'), findsOneWidget);
      expect(find.text('Custom Hint'), findsOneWidget);
    });

    testWidgets('should respect maxLines property', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('test');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RxTextField<String>(
              model: model,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Multi-line'),
            ),
          ),
        ),
      );

      // Assert
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, equals(3));
    });
  });
}
