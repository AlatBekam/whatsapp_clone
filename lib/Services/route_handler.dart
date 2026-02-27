import 'package:flutter/material.dart';
import 'package:whatsapp_clone/chat_page.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => home());
    case '/chat':
      final args = settings.arguments as Map<String, dynamic>;
      final title = args['title'] as String;
      final index = args['index'] as int;
      return MaterialPageRoute(
        builder: (context) => Chatpage(title: title, index: index),
      );

    case '/splashScreen':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case '/status_page':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    default:
      return MaterialPageRoute(builder: (context) => const home());
  }
}
