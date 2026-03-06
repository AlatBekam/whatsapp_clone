import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CommunityInfo.dart';
import 'package:whatsapp_clone/add_channel.dart';
import 'package:whatsapp_clone/channels.dart';
import 'package:whatsapp_clone/chat_page.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:whatsapp_clone/login.dart';
import 'package:whatsapp_clone/register.dart';
import 'package:whatsapp_clone/splash_screen.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';
import 'package:whatsapp_clone/CreateCommunityPage.dart';
import 'package:whatsapp_clone/status_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/home':
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

    case '/login':
      return MaterialPageRoute(builder: (context) => Login());

    case '/register':
      return MaterialPageRoute(builder: (context) => register());

    case '/statusPage':
      return MaterialPageRoute(builder: (context) => StatusPage());

    // case '/getToken':
    //   return MaterialPageRoute(builder: (context) => ApiServices.getToken());

    case '/channels':
      return MaterialPageRoute(builder: (context) => channels());

    case '/addChannel':
      return MaterialPageRoute(builder: (context) => addChannel());

    case '/kontak':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    case '/Community':
      return MaterialPageRoute(builder: (context) => KomunitasPage());

    case '/Pengaturan':
      return MaterialPageRoute(builder: (context) => PengaturanPage());

    case '/CreateCommunity':
      return MaterialPageRoute(builder: (context) => CreateCommunity());

    case '/CommunityInfo':
      final args = settings.arguments as Map<String, dynamic>;

      return MaterialPageRoute(
        builder: (context) => KomunitasInfoPage(),
        settings: RouteSettings(arguments: args),
      );

    default:
      return MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: Center(child: Text("Route tidak ditemukan"))),
      );
  }
}
