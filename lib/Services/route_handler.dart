import 'package:get/get.dart';

import 'package:whatsapp_clone/chat_page.dart' as Chat;
import 'package:whatsapp_clone/pages/channel/add_channel.dart';
import 'package:whatsapp_clone/pages/channel/channels.dart';
import 'package:whatsapp_clone/pages/community/CommunityInfo.dart';
import 'package:whatsapp_clone/pages/community/CommunityPage.dart';
import 'package:whatsapp_clone/pages/community/CreateCommunityPage.dart';
import 'package:whatsapp_clone/pages/settings/PengaturanPage.dart';
import 'package:whatsapp_clone/pages/status/add_status.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';
import 'package:whatsapp_clone/screens/home.dart';
import 'package:whatsapp_clone/screens/login.dart';
import 'package:whatsapp_clone/screens/register.dart';
import 'package:whatsapp_clone/screens/splash_screen.dart';

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

    GetPage(name: Routes.chat, page: () => Chat.ChatPage()),

    GetPage(name: Routes.splashScreen, page: () => SplashScreen()),

    GetPage(name: Routes.login, page: () => Login()),

    GetPage(name: Routes.register, page: () => register()),

    GetPage(name: Routes.statusPage, page: () => StatusPage()),

    GetPage(name: Routes.channels, page: () => channels()),

    GetPage(name: Routes.addChannel, page: () => addChannel()),

    GetPage(name: Routes.addStatus, page: () => addStatus()),

    GetPage(name: Routes.community, page: () => KomunitasPage()),

    GetPage(name: Routes.pengaturan, page: () => PengaturanPage()),

    GetPage(name: Routes.createCommunity, page: () => CreateCommunity()),

    GetPage(name: Routes.communityInfo, page: () => KomunitasInfoPage()),
  ];
}
