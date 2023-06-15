import 'dart:async';
import 'dart:io';

import 'package:chat_flutter/core/model/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;

  static final _useStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get currentUserChanges => _useStream;

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) {
      throw Exception('Erro ao criar usuário');
    }

    credential.user!.updateDisplayName(name);
    // credential.user!.updatePhotoURL(image?.path ?? 'assets/images/avatar.png');
  }

  @override
  Future<void> login(String email, String password) async {}

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
