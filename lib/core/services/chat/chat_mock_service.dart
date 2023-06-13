import 'dart:async';
import 'dart:math';

import 'package:chat_flutter/core/model/chat_message.dart';
import 'package:chat_flutter/core/model/chat_user.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Olá, tudo bem?',
      createdAt: DateTime.now().subtract(Duration(minutes: 10)),
      userId: '1',
      userName: 'João',
      userImageUrl: 'asset/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Olá, Teremos reunião hoje?	',
      createdAt: DateTime.now().subtract(Duration(minutes: 11)),
      userId: '1',
      userName: 'João 2',
      userImageUrl: 'asset/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Sim, as 14h',
      createdAt: DateTime.now().subtract(Duration(minutes: 12)),
      userId: '1',
      userName: 'João 3',
      userImageUrl: 'asset/images/avatar.png',
    )
  ];

  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    _msgs.add(newMessage);
    _controller?.add(_msgs);
    return newMessage;
  }
}
