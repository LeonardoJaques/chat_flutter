import 'package:chat_flutter/core/model/chat_message.dart';
import 'package:chat_flutter/core/model/chat_user.dart';

import 'chat_mock_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() => ChatMockService();
}
