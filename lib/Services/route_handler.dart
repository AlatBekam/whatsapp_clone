import 'package:flutter/material.dart';
import 'package:whatsapp_clone/CommunityInfo.dart';
import 'package:whatsapp_clone/Controllers/chat_controller.dart';
import 'package:whatsapp_clone/add_channel.dart';
import 'package:whatsapp_clone/add_status.dart';
import 'package:whatsapp_clone/channels.dart';
import 'package:whatsapp_clone/chat_page.dart' as Chat;
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:whatsapp_clone/login.dart';
import 'package:whatsapp_clone/register.dart';
import 'package:whatsapp_clone/splash_screen.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';
import 'package:whatsapp_clone/CreateCommunityPage.dart';
import 'package:whatsapp_clone/status_page.dart';
import 'package:get/get.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case '/home':
//       return MaterialPageRoute(builder: (context) => home());
//     // case '/chat':
//     //   final args = settings.arguments as Map<String, dynamic>?;
//     //   final title = args?['title'] as String? ?? "Chat";
//     //   final userId = args?['user_id'] as String? ?? "0";
//     //   final chatId = args?['chat_id'] as String?;
//     //   return MaterialPageRoute(
//     //     builder: (context) => Chatpage(
//     //       title: title,
//     //       userId: userId,
//     //     ),
//     //     settings: RouteSettings(
//     //       arguments: {
//     //         'title': title,
//     //         'user_id': userId,
//     //         'chat_id': chatId,
//     //       },
//     //     ),
//     //   );

//     case '/splashScreen':
//       return MaterialPageRoute(builder: (context) => SplashScreen());

//     case '/login':
//       return MaterialPageRoute(builder: (context) => Login());

//     case '/register':
//       return MaterialPageRoute(builder: (context) => register());

//     case '/statusPage':
//       return MaterialPageRoute(builder: (context) => StatusPage());

//     // case '/getToken':
//     //   return MaterialPageRoute(builder: (context) => ApiServices.getToken());

//     case '/channels':
//       return MaterialPageRoute(builder: (context) => channels());

//     case '/addChannel':
//       return MaterialPageRoute(builder: (context) => addChannel());

//     case '/addStatus':
//       return MaterialPageRoute(builder: (context) => addStatus());

//     case '/kontak':
//       return MaterialPageRoute(builder: (context) => SplashScreen());

//     case '/Community':
//       return MaterialPageRoute(builder: (context) => KomunitasPage());

//     case '/Pengaturan':
//       return MaterialPageRoute(builder: (context) => PengaturanPage());

//     case '/CreateCommunity':
//       return MaterialPageRoute(builder: (context) => CreateCommunity());

//     case '/CommunityInfo':
//       final args = settings.arguments as Map<String, dynamic>;

//       return MaterialPageRoute(
//         builder: (context) => KomunitasInfoPage(),
//         settings: RouteSettings(arguments: args),
//       );

//     default:
//       return MaterialPageRoute(
//         builder: (context) =>
//             Scaffold(body: Center(child: Text("Route tidak ditemukan"))),
//       );
//   }
// }

class AppRoutes {
  static final routes = [
    GetPage(name: '/home', page: () => home()),
    GetPage(name: '/SplashScreen', page: () => SplashScreen()),
    GetPage(name: '/login', page: () => Login()),

    GetPage(
      name: '/chat',
      page: () {
        return Chat.ChatPage();
      },
    ),
  ];
}
