import 'package:chat_flutter/components/auth_form.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../core/model/auth_form_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<void> _handleAuthFormSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);
      if (formData.isLogin) {
        AuthService().login(formData.email, formData.password);
      } else {
        AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (e) {
      _showError('Ocorreu um erro inesperado! Tente novamente mais tarde.');
      setState(() => _isLoading = false);
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
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
