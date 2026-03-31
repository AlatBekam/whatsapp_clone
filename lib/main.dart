import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Controllers/LoadingController.dart';
import 'package:whatsapp_clone/Services/gambar_service.dart';
import 'package:whatsapp_clone/controllers/auth_controller.dart';
import 'package:whatsapp_clone/controllers/channel_controller.dart';
import 'package:whatsapp_clone/controllers/status_controller.dart';
import 'package:whatsapp_clone/controllers/chat_controller.dart';
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

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /// menghilangkan debug banner yg di kanan atas
      debugShowCheckedModeBanner: false,

      /// route pertama saat aplikasi dibuka
      initialRoute: Routes.splashScreen,

      /// daftar routing aplikasi
      getPages: AppRoutes.routes,

      /// pengganti default route lama yg ada di file routes_handler.dart
      unknownRoute: GetPage(
        name: "/notfound",
        page: () =>
            Scaffold(body: Center(child: Text("Route tidak ditemukan"))),
      ),

      themeMode: ThemeMode.system,
      theme: CustomAppTheme.light(),
      darkTheme: CustomAppTheme.dark(),
    );
  }
}
