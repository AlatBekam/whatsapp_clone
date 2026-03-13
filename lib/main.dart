import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_clone/Controllers/chat_controller.dart';
import 'package:whatsapp_clone/Services/route_handler.dart';
import 'package:get/get.dart';

void main() {
  initialGetx();

  runApp(WeatherApp());
}

initialGetx() {
  Get.put(ChatController());
}

// ignore: camel_case_types
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      getPages: AppRoutes.routes,
    );
  }
}

// ignore: camel_case_types
// class WeatherApp extends StatelessWidget {
//   const WeatherApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       onGenerateRoute: router.generateRoute,
//       // inisialisasi halaman router awal disaat app terbuka
//       initialRoute: "/channels",
//     );
//   }
// }
