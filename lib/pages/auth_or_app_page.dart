import 'package:chat_flutter/core/model/chat_user.dart';
import 'package:chat_flutter/core/services/auth/auth_service.dart';
import 'package:chat_flutter/pages/auth_page.dart';
import 'package:chat_flutter/pages/chat_page.dart';
import 'package:chat_flutter/pages/loding_pages.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ChatUser?>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPages();
        } else {
          return snapshot.hasData ? const ChatPage() : const AuthPage();
        }
      }),
      stream: AuthService().currentUserChanges,
    ));
  }
}
