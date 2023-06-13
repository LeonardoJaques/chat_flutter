import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_flutter/core/model/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static final _defaultUsers = ChatUser(
    id: '1',
    name: 'teste',
    email: 'teste@teste.com',
    imageUrl: 'assets/images/avatar.png',
  );

  static Map<String, ChatUser> _users = {
    _defaultUsers.email: _defaultUsers,
  };
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;

  static final _useStream = Stream<ChatUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUsers);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get currentUserChanges => _useStream;

  @override
  Future<void> login(String email, String password) async {
    if (!_users.containsKey(email)) {
      throw Exception('Usuário não encontrado');
    }
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random.secure().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
