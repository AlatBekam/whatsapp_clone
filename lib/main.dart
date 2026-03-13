import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Services/route_handler.dart';

void main() {
  runApp(const WhatsApp());
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
        page: () => Scaffold(
          body: Center(
            child: Text("Route tidak ditemukan"),
          ),
        ),
      ),

    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:whatsapp_clone/Services/route_handler.dart' as router;
// import 'package:get/get.dart';

// void main() {
//   runApp(WhatsApp());
// }

// // ignore: camel_case_types
// class WhatsApp extends StatelessWidget {
//   const WhatsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       // Inisialisasi router
//       onGenerateRoute: router.generateRoute,
//       // inisialisasi halaman router awal disaat app terbuka
//       initialRoute: "/splashScreen",
//     );
//   }
// }