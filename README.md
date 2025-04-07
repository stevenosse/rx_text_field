# RX Text Field

A reactive text field widget for Flutter that synchronizes with data models. This package provides a simple way to bind text fields to reactive data models, making it easy to create forms that automatically update when the model changes and vice versa.

## Features

- **Two-way data binding**: Text fields automatically update when the model changes and update the model when the text field changes
- **Support for complex objects**: Bind text fields to specific fields in complex objects
- **Simple API**: Easy to use with minimal boilerplate
- **Flexible**: Works with any data type, including strings, numbers, custom objects, and maps

## Getting started

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  rx_text_field: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Simple String Binding

For simple string values, you can bind a text field directly to a `ReactiveModel<String>`:

```dart
// Create a reactive model with an initial value
final nameModel = ReactiveModel<String>('');

// Bind a text field to the model
ReactiveTextField(
  labelText: 'Name',
  model: nameModel,
)
```

### Complex Object Binding

For complex objects, you can use the `field` and `onChanged` parameters to bind to specific fields:

```dart
// Create a reactive model with a complex object
final loginModel = ReactiveModel(LoginRequest(username: '', password: ''));

// Bind a text field to the username field
ReactiveTextField(
  labelText: 'Username',
  model: loginModel,
  field: (model) => model.username,
  onChanged: (model, value) => model.username = value,
)

// Bind a text field to the password field with obscured text
ReactiveTextField(
  labelText: 'Password',
  model: loginModel,
  field: (model) => model.password,
  onChanged: (model, value) => model.password = value,
  obscureText: true,
)
```

### Map binding

You can also bind to fields in a Map:

```dart
// Create a reactive model with a Map
final mapModel = ReactiveModel({'name': '', 'age': ''});

// Bind a text field to the 'name' field
ReactiveTextField(
  labelText: 'Name',
  model: mapModel,
  field: (model) => model['name']!,
  onChanged: (model, value) => model['name'] = value,
)
```

### Custom decoration

You can customize the appearance of the text field using the `decoration` parameter:

```dart
ReactiveTextField(
  labelText: 'Email',
  model: emailModel,
  decoration: InputDecoration(
    labelText: 'Email Address',
    hintText: 'Enter your email',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
)
```

## Complete example

See the `/example` folder for a complete example of how to use the package.

```dart
import 'package:flutter/material.dart';
import 'package:rx_text_field/rx_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginRequest = ReactiveModel(LoginRequest(username: '', password: ''));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReactiveTextField(
            labelText: 'Username',
            model: loginRequest,
            field: (model) => model.username,
            onChanged: (model, value) => model.username = value,
          ),
          ReactiveTextField(
            labelText: 'Password',
            model: loginRequest,
            field: (model) => model.password,
            onChanged: (model, value) => model.password = value,
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              print('Login: ${loginRequest.data}');
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

## Additional information

### ReactiveModel

The `ReactiveModel` class is a wrapper around any data type that provides reactive capabilities. It extends `ChangeNotifier` to notify listeners when the data changes.

```dart
// Create a reactive model
final model = ReactiveModel<String>('initial value');

// Update the value
model.updateField('new value');

// Or use the setter
model.value = 'another value';

// Get the current value
print(model.value);
```

### Contributing

Contributions are welcome! If you find a bug or want to add a feature, please open an issue or submit a pull request.

### License

This package is licensed under the MIT License - see the LICENSE file for details.
