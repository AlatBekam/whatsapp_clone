import 'package:get/get.dart';

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

class Routes {
  static const home = "/home";
  static const chat = "/chat";
  static const splashScreen = "/splashScreen";
  static const login = "/login";
  static const register = "/register";
  static const statusPage = "/statusPage";
  static const channels = "/channels";
  static const addChannel = "/addChannel";
  static const addStatus = "/addStatus";
  static const community = "/Community";
  static const pengaturan = "/Pengaturan";
  static const createCommunity = "/CreateCommunity";
  static const communityInfo = "/CommunityInfo";
}

class AppRoutes {
  static final routes = [
    GetPage(name: Routes.home, page: () => home()),

    GetPage(
      name: Routes.chat,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final title = args?['title'] ?? "Chat";
        final userId = args?['user_id'] ?? "0";

        return Chatpage(title: title, userId: userId);
      },
    ),

    GetPage(name: Routes.splashScreen, page: () => SplashScreen()),

    GetPage(name: Routes.login, page: () => Login()),

    GetPage(name: Routes.register, page: () => register()),

    GetPage(name: Routes.statusPage, page: () => StatusPage()),

    GetPage(name: Routes.addStatus, page: () => addStatus()),

    GetPage(name: Routes.channels, page: () => channels()),

    GetPage(name: Routes.addChannel, page: () => addChannel()),

    GetPage(name: Routes.community, page: () => KomunitasPage()),

    GetPage(name: Routes.pengaturan, page: () => PengaturanPage()),

    GetPage(name: Routes.createCommunity, page: () => CreateCommunity()),

    GetPage(name: Routes.communityInfo, page: () => KomunitasInfoPage()),
  ];
}

/*
CARA NAVIGASI JIKA MENGGUNAKAN ROUTE YG MENERAPKAN GetX
1. Perpindahan halaman
Awalnya
Navigator.pushNamed(context, "/Community");
Menjadi
Get.toNamed(Routes.community);

2. Kembali ke halaman sebelumnya
Awalnya
Navigator.pop(context);
Menjadi
Get.back();

3. Mengirim Data
Awalnya
Navigator.pushNamed(
  context,
  "/CommunityInfo",
  arguments: community,
);
Menjadi
Get.toNamed(
  Routes.communityInfo,
  arguments: community,
);

4. Mengambil Data
Awalnya
ModalRoute.of(context)!.settings.arguments
Menjadi
final community = Get.arguments;
*/

// Route<dynamic> generateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     case '/home':
//       return MaterialPageRoute(builder: (context) => home());
//     case '/chat':
//       final args = settings.arguments as Map<String, dynamic>?;
//       final title = args?['title'] as String? ?? "Chat";
//       final userId = args?['user_id'] as String? ?? "0";
//       return MaterialPageRoute(
//         builder: (context) => Chatpage(title: title, userId: userId),
//       );

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
