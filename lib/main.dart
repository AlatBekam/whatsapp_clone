import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Controllers/LoadingController.dart';
import 'package:whatsapp_clone/Services/gambar_service.dart';
import 'package:whatsapp_clone/controllers/auth_controller.dart';
import 'package:whatsapp_clone/controllers/channel_controller.dart';
import 'package:whatsapp_clone/controllers/status_controller.dart';
import 'package:whatsapp_clone/controllers/chat_controller.dart';
import 'package:whatsapp_clone/pages/settings/PengaturanPage.dart';
import 'package:whatsapp_clone/screens/home.dart';
import 'package:whatsapp_clone/services/route_handler.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';
import 'controllers/CommunityController.dart';

void main() {
  runApp(const WhatsApp());
  initialGetx();
}

initialGetx() {
  Get.put(CommunityController());
  Get.put(ControllerStatus());
  Get.put(ControllerChannel());
  Get.put(ChatController());
  Get.put(LoadingController());
  Get.put(AuthController());
  Get.put(GambarService());
}

enum AppTheme {
  Light,
  Dark,
  Default,
}

class WhatsApp extends StatefulWidget {
  const WhatsApp({super.key});

  @override
  State<WhatsApp> createState() => _WhatsAppState();
}

class _WhatsAppState extends State<WhatsApp> {
  ThemeMode _themeMode = ThemeMode.light;
  AppTheme _currentAppTheme = AppTheme.Light;


  // ThemeMode get themeMode {
  //     switch (_currentAppTheme) {
  //       case AppTheme.Light:
  //         return ThemeMode.light;
  //       case AppTheme.Dark:
  //         return ThemeMode.dark;
  //       case AppTheme.Default:
  //         return ThemeMode.system;
  //     }
  //   }


void changeTheme(AppTheme mode) {
  setState(() {
    _currentAppTheme = mode;
    switch (mode) {
      case AppTheme.Light:
        _themeMode = ThemeMode.light;
        print('Tema diubah ke Light utama');
        break;
      case AppTheme.Dark:
        _themeMode = ThemeMode.dark;
        print('Tema diubah ke Dark utama');
        break;
      case AppTheme.Default:
        _themeMode = ThemeMode.system;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /// menghilangkan debug banner yg di kanan atas
      debugShowCheckedModeBanner: false,

      /// route pertama saat aplikasi dibuka
      initialRoute: Routes.splashScreen,

      /// daftar routing aplikasi
      getPages: [
        ...AppRoutes.routes,
        GetPage(name: Routes.settings, page: () => PengaturanPage(onThemeChanged: changeTheme, currentTheme: _currentAppTheme,)),
      ],

      /// pengganti default route lama yg ada di file routes_handler.dart
      unknownRoute: GetPage(
        name: "/notfound",
        page: () =>
            Scaffold(body: Center(child: Text("Route tidak ditemukan"))),
      ),

      themeMode: _themeMode,
      theme: CustomAppTheme.light(),
      darkTheme: CustomAppTheme.dark(),
    );
  }
}
