import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/route_handler.dart' as router;

void main() {
  runApp(weatherApp());
}

// ignore: camel_case_types
class weatherApp extends StatelessWidget {
  const weatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Inisialisasi router
      onGenerateRoute: router.generateRoute,
      // inisialisasi halaman router awal disaat app terbuka
      initialRoute: "/splashScreen",
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
