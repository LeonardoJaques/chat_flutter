import 'package:chat_flutter/core/model/chat_notification.dart';
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
}
