import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Controllers/channel_controller.dart';
import 'package:whatsapp_clone/Controllers/status_controller.dart';
import 'package:whatsapp_clone/Services/route_handler.dart';
import 'package:get/get.dart';

void main() {
  runApp(whatsAppClone());

  Get.put(controllerStatus);
  Get.put(controllerChannel);
}

// ignore: camel_case_types
class whatsAppClone extends StatelessWidget {
  const whatsAppClone({super.key});

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
    );
  }
}

// ignore: camel_case_types
// class weatherApp extends StatelessWidget {
//   const weatherApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       onGenerateRoute: router.generateRoute,
//       // inisialisasi halaman router awal disaat app terbuka
//       initialRoute: "/channels",
//     );
//   }
// }
