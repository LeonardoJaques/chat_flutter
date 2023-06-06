import 'dart:io';

enum AuthMode { signup, login }

class AuthFormData {
  String email = '';
  String password = '';
  String name = '';
  String confirmPassword = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isSignup {
    return _mode == AuthMode.signup;
  }

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  void toggleAuthMode() {
    _mode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
