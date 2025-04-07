import 'package:flutter_test/flutter_test.dart';
import 'package:rx_text_field/rx_text_field.dart';

// Test model class for complex object testing
class TestUser {
  String username;
  String password;
  TestUser({this.username = '', this.password = ''});
}

void main() {
  group('ReactiveModel', () {
    test('should initialize with provided data', () {
      // Arrange
      const initialValue = 'test';

      // Act
      final model = ReactiveModel<String>(initialValue);

      // Assert
      expect(model.data, equals(initialValue));
      expect(model.value, equals(initialValue));
    });

    test('should update value and notify listeners', () {
      // Arrange
      final model = ReactiveModel<String>('initial');
      var listenerCallCount = 0;
      model.addListener(() {
        listenerCallCount++;
      });

      // Act
      model.updateField('updated');

      // Assert
      expect(model.data, equals('updated'));
      expect(listenerCallCount, equals(1));
    });

    test('should update value using setter and notify listeners', () {
      // Arrange
      final model = ReactiveModel<String>('initial');
      var listenerCallCount = 0;
      model.addListener(() {
        listenerCallCount++;
      });

      // Act
      model.value = 'updated';

      // Assert
      expect(model.data, equals('updated'));
      expect(listenerCallCount, equals(1));
    });

    test('should not notify listeners if value is the same', () {
      // Arrange
      final model = ReactiveModel<String>('initial');
      var listenerCallCount = 0;
      model.addListener(() {
        listenerCallCount++;
      });

      // Act
      model.value = 'initial'; // Same value

      // Assert
      expect(model.data, equals('initial'));
      expect(listenerCallCount, equals(0));
    });

    test('should work with complex objects', () {
      // Arrange
      final loginRequest = TestUser(username: 'user', password: 'pass');
      final model = ReactiveModel<TestUser>(loginRequest);

      // Act
      final newRequest = TestUser(username: 'newuser', password: 'newpass');
      model.value = newRequest;

      // Assert
      expect(model.data.username, equals('newuser'));
      expect(model.data.password, equals('newpass'));
    });

    test('toString should return formatted string', () {
      // Arrange
      final model = ReactiveModel<String>('test');

      // Act & Assert
      expect(model.toString(), equals('ReactiveModel(test)'));
    });
  });
}
