import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/Services/checl_if_login.dart';

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
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    ChecklIfLogin().checkIfLogin(context);
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
                'assets/svg/whatsapp.svg',
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
