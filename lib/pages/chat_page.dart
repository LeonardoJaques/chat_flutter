import 'package:chat_flutter/components/menssages.dart';
import 'package:chat_flutter/components/new_message.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DropdownButton(
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
