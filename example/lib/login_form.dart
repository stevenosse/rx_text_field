import 'package:flutter/material.dart';
import 'package:rx_text_field/rx_text_field.dart';

class SimpleFormExample extends StatelessWidget {
  SimpleFormExample({super.key});

  final nameModel = ReactiveModel<String>('');
  final emailModel = ReactiveModel<String>('');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Simple String Models',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RxTextField<String>(
            model: nameModel,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: RxTextFormField<String>(
            model: emailModel,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current values:'),
              ListenableBuilder(
                listenable: nameModel,
                builder: (context, child) => Text('Name: ${nameModel.value}'),
              ),
              ListenableBuilder(
                listenable: emailModel,
                builder: (context, child) => Text('Email: ${emailModel.value}'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class User {
  String username;
  String password;
  String firstName;
  String lastName;

  User({
    this.username = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
  });

  @override
  String toString() {
    return 'User(username: $username, firstName: $firstName, lastName: $lastName, password: $password)';
  }
}

class CompoundFormExample extends StatefulWidget {
  const CompoundFormExample({super.key});

  @override
  State<CompoundFormExample> createState() => _CompoundFormExampleState();
}

class _CompoundFormExampleState extends State<CompoundFormExample> {
  final userModel = ReactiveModel<User>(User());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Compound Object Model',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                RxTextFormField<User>(
                  model: userModel,
                  field: (user) => user.username,
                  onChanged: (user, value) => user.username = value,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RxTextFormField<User>(
                  model: userModel,
                  field: (user) => user.password,
                  onChanged: (user, value) => user.password = value,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                RxTextField<User>(
                  model: userModel,
                  field: (user) => user.firstName,
                  onChanged: (user, value) => user.firstName = value,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                RxTextField<User>(
                  model: userModel,
                  field: (user) => user.lastName,
                  onChanged: (user, value) => user.lastName = value,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Form valid: ${userModel.value}')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListenableBuilder(
            listenable: userModel,
            builder:
                (context, child) =>
                    Text('Current user data:\n${userModel.value}'),
          ),
        ),
      ],
    );
  }
}

class MapBindingExample extends StatelessWidget {
  MapBindingExample({super.key});

  final mapModel = ReactiveModel<Map<String, String>>({'name': '', 'age': ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Map Binding Example',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          RxTextField<Map<String, String>>(
            model: mapModel,
            field: (model) => model['name']!,
            onChanged: (model, value) => model['name'] = value,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          RxTextField<Map<String, String>>(
            model: mapModel,
            field: (model) => model['age']!,
            onChanged: (model, value) => model['age'] = value,
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
              hintText: 'Enter your age',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ListenableBuilder(
            listenable: mapModel,
            builder:
                (context, child) => Text(
                  'Current map data:\n'
                  'Name: ${mapModel.value["name"]}\n'
                  'Age: ${mapModel.value["age"]}',
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Form valid: ${mapModel.value}')),
                );
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleFormExample(),
        const Divider(height: 32),
        const CompoundFormExample(),
        const Divider(height: 32),
        MapBindingExample(),
        const SizedBox(height: 50),
      ],
    );
  }
}
