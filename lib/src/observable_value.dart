import 'package:flutter/foundation.dart';

/// A reactive model that wraps data and notifies listeners when the data changes.
///
/// This class extends [ChangeNotifier] to provide reactive capabilities to any data type.
/// It can be used with simple values like strings and numbers, or with complex objects
/// like custom data models and maps.
///
/// Type parameter [T] represents the type of data being wrapped.
class ObservableValue<T> extends ChangeNotifier {
  /// The data being wrapped by this reactive model.
  T data;

  /// Creates a new [ObservableValue] with the given initial [data].
  ObservableValue(this.data);

  /// Updates the field with a new value and notifies listeners.
  ///
  /// This method is primarily used for simple value types where direct assignment
  /// is sufficient. For complex objects, consider using specific field updaters.
  ///
  /// The [value] parameter will be cast to type [T].
  void updateField(dynamic value) {
    data = value as T;
    notifyListeners();
  }

  /// Updates the entire data object and notifies listeners.
  ///
  /// This is useful when you want to replace the entire data object rather than
  /// updating individual fields.
  set value(T newValue) {
    if (data != newValue) {
      data = newValue;
      notifyListeners();
    }
  }

  /// Gets the current data value.
  T get value => data;

  @override
  String toString() => 'ObservableValue($data)';
}
