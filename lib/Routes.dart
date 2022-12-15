import 'package:flutter/material.dart';
import 'package:flutter_chat_bot_task/views/ChatRoom.dart';
import 'package:flutter_chat_bot_task/views/Star.dart';

Map<String, WidgetBuilder> routes = {
  Star.route: (context) => Star(),
  ChatState.route: (context) => Chat(),
};
