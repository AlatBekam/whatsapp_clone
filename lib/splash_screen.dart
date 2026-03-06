import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _splashScreen();
}

// ignore: camel_case_types
class _splashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfLogin();
  }

  Future<void> _checkIfLogin() async {
    String? token = await AuthService().getToken();

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (token == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return;
    }

    Map<String, dynamic> decodeToken = JwtDecoder.decode(token!);
    int userEXP = decodeToken['exp'];
    int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (userEXP <= timeNow) {
      await AuthService().removeToken();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buildd
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(height: 10, width: 10),
            Container(
              child: SvgPicture.asset(
                'assets/whatsapp.svg',
                width: 100,
                height: 100,
              ),
            ),
            Container(height: 60, child: Text('WhatsApp')),
          ],
        ),
      ),
    );
  }
}
// class _splashScreen extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   bool isLogin = false;
//   var content;

//   Future<void> _checkIfLogin() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var token = localStorage.getString('token');

//     if (token != null) {
//       if (mounted) {
//         setState(() {
//           isLogin = true;
//         });
//       }
//     }
//   }

//   @override
//   void initState() {
//     _checkIfLogin();
//     if (isLogin) {
//       content = "/";
//     } else {
//       content = "/login";
//     }

//     // TODO: implement initState
//     super.initState();

//     // Pembuatan delay selama 5000 milidetik disaat aplikasi dibuka
//     Future.delayed(Duration(milliseconds: 500), () {
//       // setelah delay selesai, maka halaman akan didirect ke '/'

//       // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
//       Navigator.of(context).pushNamedAndRemoveUntil(content, (route) => false);
//     });
//   }

//   // Menghapus objek dari tree
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement buildd
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Container(height: 10, width: 10),
//             Container(
//               child: SvgPicture.asset(
//                 'assets/whatsapp.svg',
//                 width: 100,
//                 height: 100,
//               ),
//             ),
//             Container(height: 60, child: Text('WhatsApp')),
//           ],
//         ),
//       ),
//     );
//   }
// }
