import 'package:flutter/foundation.dart';

/// A reactive model that wraps data and notifies listeners when the data changes.
///
/// This class extends [ChangeNotifier] to provide reactive capabilities to any data type.
/// It can be used with simple values like strings and numbers, or with complex objects
/// like custom data models and maps.
///
/// Type parameter [T] represents the type of data being wrapped.
class ReactiveModel<T> extends ChangeNotifier {
  /// The data being wrapped by this reactive model.
  T data;

  /// Creates a new [ReactiveModel] with the given initial [data].
  ReactiveModel(this.data);

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

  /// Updates a field using a callback function and then notifies listeners.
  ///
  /// This method is useful for updating complex objects where you need to modify
  /// a specific field or property. The callback receives the current data and
  /// should perform the necessary updates.
  ///
  /// Example:
  /// ```dart
  /// model.updateWithCallback((data) {
  ///   data.someField = newValue;
  /// });
  /// ```
  void updateWithCallback(void Function(T) callback) {
    callback(data);
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
  String toString() => 'ReactiveModel($data)';
}
