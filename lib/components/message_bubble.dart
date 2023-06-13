import 'dart:io';

import 'package:chat_flutter/core/model/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToCurrentUser,
  });
  final ChatMessage message;
  final bool belongsToCurrentUser;
  static const String defaultImage = 'assets/images/avatar.png';

  Widget _showUserImage(String? imageUrl) {
    ImageProvider? imageProvider;
    final uri = Uri.tryParse(imageUrl ?? '');

    if (uri!.path.contains(defaultImage)) {
      imageProvider = const AssetImage(defaultImage);
    } else if (uri.scheme.contains('http') || uri.scheme.contains('https')) {
      imageProvider = NetworkImage(uri.toString());
    } else {
      imageProvider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey,
      backgroundImage: imageProvider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: belongsToCurrentUser
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                  bottomRight: belongsToCurrentUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  Text(message.userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: belongsToCurrentUser
                            ? Colors.black
                            : Theme.of(context).colorScheme.onSecondary,
                      )),
                  Text(message.text,
                      style: TextStyle(
                        color: belongsToCurrentUser
                            ? Colors.black
                            : Theme.of(context).colorScheme.onSecondary,
                      )),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageUrl),
        ),
      ],
    );
  }
}
