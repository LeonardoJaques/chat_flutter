import 'dart:io';

import 'package:chat_flutter/core/model/chat_user.dart';

abstract class AuthService {
  ChatUser? get currentUser;
  Stream<ChatUser?> get currentUserChanges;

  Future<void> signup(
    String email,
    String password,
    String name,
    File image,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> logout();
}
