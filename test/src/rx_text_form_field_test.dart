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
  group('RxTextFormField', () {
    testWidgets('should initialize with simple string model', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('initial text');

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              child: RxTextFormField<String>(
                model: model,
                decoration: const InputDecoration(labelText: 'Test Field'),
              ),
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
            body: Form(
              child: RxTextFormField<String>(
                model: model,
                decoration: const InputDecoration(labelText: 'Test Field'),
              ),
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
            body: Form(
              child: RxTextFormField<String>(
                model: model,
                decoration: const InputDecoration(labelText: 'Test Field'),
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField), 'user input');

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
            body: Form(
              child: RxTextFormField<TestUser>(
                model: model,
                decoration: const InputDecoration(labelText: 'Username'),
                field: (m) => m.username,
                onChanged: (m, value) => m.username = value,
              ),
            ),
          ),
        ),
      );

      // Assert initial state
      expect(find.text('user'), findsOneWidget);

      // Act - update through UI
      await tester.enterText(find.byType(TextFormField), 'newuser');

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

    testWidgets('should validate input when validator is provided', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('');
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: RxTextFormField<String>(
                model: model,
                decoration: const InputDecoration(labelText: 'Required Field'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Field is required'
                            : null,
              ),
            ),
          ),
        ),
      );

      // Act - validate empty field
      formKey.currentState!.validate();
      await tester.pump();

      // Assert - error message is shown
      expect(find.text('Field is required'), findsOneWidget);

      // Act - enter text and validate again
      await tester.enterText(find.byType(TextFormField), 'valid input');
      formKey.currentState!.validate();
      await tester.pump();

      // Assert - error message is gone
      expect(find.text('Field is required'), findsNothing);
    });

    testWidgets('should call onSaved when form is saved', (
      WidgetTester tester,
    ) async {
      // Arrange
      final model = ObservableValue<String>('initial');
      final formKey = GlobalKey<FormState>();
      String? savedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: RxTextFormField<String>(
                model: model,
                decoration: const InputDecoration(labelText: 'Test Field'),
                onSaved: (value) => savedValue = value,
              ),
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextFormField), 'saved text');
      formKey.currentState!.save();

      // Assert
      expect(savedValue, equals('saved text'));
    });
  });
}
