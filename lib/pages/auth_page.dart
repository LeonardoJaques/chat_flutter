import 'package:chat_flutter/components/auth_form.dart';
import 'package:flutter/material.dart';

import '../model/auth_form_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;
  void _handleAuthFormSubmit(AuthFormData formData) {
    setState(() => _isLoading = true);
    print('AuthForm');
    print(formData.name);
    print(formData.email);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(children: [
        Center(
          child: SingleChildScrollView(
            child: AuthForm(
              onSubmit: _handleAuthFormSubmit,
            ),
          ),
        ),
        if (_isLoading)
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
    );
  }
}
