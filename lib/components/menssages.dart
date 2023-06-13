import 'package:chat_flutter/components/message_bubble.dart';
import 'package:chat_flutter/core/model/chat_message.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Sem dados. Verifique sua conexão.'),
          );
        } else {
          final msg = snapshot.data as List<ChatMessage>;
          return ListView.builder(
            reverse: true,
            itemCount: msg.length,
            itemBuilder: (ctx, i) => MessageBubble(
              key: ValueKey(msg[i].id),
              message: msg[i],
              belongsToCurrentUser: currentUser?.id == msg[i].userId,
            ),
          );
        }
      },
    );
  }
}
