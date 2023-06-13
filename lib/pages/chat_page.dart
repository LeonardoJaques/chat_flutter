import 'package:chat_flutter/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('ChatPage'),
          ),
          TextButton(
              onPressed: () => AuthMockService().logout(),
              child: const Text('Logout'))
        ],
      ),
    );
  }
}