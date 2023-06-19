import 'package:chat_flutter/core/model/chat_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatNotificationService with ChangeNotifier {
  List<ChatNotification> _items = [];
  List<ChatNotification> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> add(ChatNotification notification) async {
    _items.add(notification);
    notifyListeners();
  }

  Future<void> remove(int index) async {
    _items.removeAt(index);
    notifyListeners();
  }

  //push notification
  Future<void> init() async {
    await _configureForground();
  }

  Future<bool> get _isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  Future<void> _configureForground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureTermineted() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen((message) async {
        RemoteMessage? initialMessage =
            await FirebaseMessaging.instance.getInitialMessage();
        _messageHandler(initialMessage);
      });
    }
  }

  Future<void> _messageHandler(RemoteMessage? message) async {
    if (message?.notification != null) {
      await add(
        ChatNotification(
          title: message?.notification!.title! ?? 'Não informado',
          body: message?.notification!.body! ?? 'Não informado',
        ),
      );
    }
  }
}
