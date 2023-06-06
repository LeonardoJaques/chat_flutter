import 'dart:io';

import 'package:chat_flutter/core/model/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  @override
  ChatUser? get currentUser => throw UnimplementedError();

  @override
  Stream<ChatUser?> get currentUserChanges => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> signup(String email, String password, String name, File image) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
