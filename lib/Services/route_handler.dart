import 'package:flutter/material.dart';
import 'package:whatsapp_clone/channels.dart';
import 'package:whatsapp_clone/chat_page.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:whatsapp_clone/login.dart';
import 'package:whatsapp_clone/register.dart';
import 'package:whatsapp_clone/splash_screen.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(builder: (context) => home());
    case '/chat':
      final args = settings.arguments as Map<String, dynamic>?;
      final title = args?['title'] as String? ?? "Chat";
      final index = args?['index'] as int? ?? 0;
      return MaterialPageRoute(
        builder: (context) => Chatpage(
          title: title, 
          index: index,
        ),
      );

    case '/splashScreen':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case '/login':
      return MaterialPageRoute(builder: (context) => Login());

    case '/register':
      return MaterialPageRoute(builder: (context) => register());

    case '/status_page':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    // case '/getToken':
    //   return MaterialPageRoute(builder: (context) => ApiServices.getToken());

    case '/channels':
      return MaterialPageRoute(builder: (context) => channels());

    case '/kontak':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    default:
      return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text("Route tidak ditemukan"))),
      );
  }
}
