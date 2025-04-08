# RX Text Field

A Flutter package providing reactive text field widgets that automatically synchronize with data models. Built for creating forms with automatic two-way data binding.

[![pub package](https://img.shields.io/pub/v/rx_text_field.svg)](https://pub.dev/packages/rx_text_field)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 🔄 **Two-way Data Binding**: Automatic synchronization between UI and data models <br />
- 🎯 **Type Safety**: Generic typing for model data  <br />
- 📋 **Form Support**: Built-in form validation and state management <br />
- 🔧 **Flexible API**: Works with simple values and complex objects <br />
- 🎨 **Full Customization**: All standard TextField properties supported <br />
- ⚡ **Reactive Updates**: Efficient model-based reactivity <br />

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  rx_text_field: ^0.0.1
```

## Core Components

### ReactiveModel<T>

A wrapper class that makes any data type reactive:

```dart
final model = ReactiveModel<String>('initial value');
model.value = 'new value'; // Notifies listeners
```

### RxTextField<T>

A basic reactive text field:

```dart
RxTextField<String>(
  model: stringModel,
  decoration: InputDecoration(labelText: 'Name'),
)
```

### RxTextFormField<T>

A form-enabled reactive text field with validation:

```dart
RxTextFormField<String>(
  model: emailModel,
  decoration: InputDecoration(labelText: 'Email'),
  validator: (value) => value?.contains('@') ?? false 
    ? null 
    : 'Invalid email',
)
```

## Usage Examples

### Simple string binding

```dart
final nameModel = ReactiveModel<String>('');

RxTextField<String>(
  model: nameModel,
  decoration: InputDecoration(
    labelText: 'Name',
    border: OutlineInputBorder(),
  ),
)
```

### Complex object binding

```dart
class User {
  String username;
  String password;
  User({this.username = '', this.password = ''});
}

final userModel = ReactiveModel<User>(User());

RxTextField<User>(
  model: userModel,
  field: (user) => user.username,
  onChanged: (user, value) => user.username = value,
  decoration: InputDecoration(labelText: 'Username'),
)
```

### Form validation

```dart
final formKey = GlobalKey<FormState>();
final emailModel = ReactiveModel<String>('');

Form(
  key: formKey,
  child: RxTextFormField<String>(
    model: emailModel,
    decoration: InputDecoration(labelText: 'Email'),
    validator: (value) {
      if (value?.isEmpty ?? true) return 'Email is required';
      if (!value!.contains('@')) return 'Invalid email format';
      return null;
    },
  ),
)

// Validate form
if (formKey.currentState!.validate()) {
  // Form is valid
}
```

### Map binding

```dart
final mapModel = ReactiveModel<Map<String, String>>({'name': ''});

RxTextField<Map<String, String>>(
  model: mapModel,
  field: (map) => map['name']!,
  onChanged: (map, value) => map['name'] = value,
  decoration: InputDecoration(labelText: 'Name'),
)
```

## Features and limitations

### Supported
- ✅ Simple value binding
- ✅ Complex object binding
- ✅ Form validation
- ✅ Custom decorations
- ✅ All standard TextField properties

### Limitations
- ⚠️ Model must implement equality for optimal performance
- ⚠️ Field and onChanged must be provided together for complex objects

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
