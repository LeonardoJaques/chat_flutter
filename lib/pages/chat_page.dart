import 'package:chat_flutter/components/menssages.dart';
import 'package:chat_flutter/components/new_message.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/notification/chat_notification_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                icon: Icon(Icons.more_vert,
                    color: Theme.of(context).primaryIconTheme.color),
                // Lista de opções do botão
                items: const [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Sair'),
                      ],
                    ),
                  )
                ],
                onChanged: (item) {
                  if (item == 'logout') {
                    AuthService().logout();
                  }
                }),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const NotificationPage(),
                    ),
                  );
                },
                icon: Icon(Icons.notifications,
                    color: Theme.of(context).primaryIconTheme.color),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
