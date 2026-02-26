import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _splashScreen();
}

// ignore: camel_case_types
class _splashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Pembuatan delay selama 5000 milidetik disaat aplikasi dibuka
    Future.delayed(Duration(milliseconds: 500), () {
      // setelah delay selesai, maka halaman akan didirect ke '/'
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    });
  }

  // Menghapus objek dari tree
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
