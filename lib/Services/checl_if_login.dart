import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

class ChecklIfLogin {
  Future<void> checkIfLogin(BuildContext context) async {
    String? token = await AuthService().getToken();

    if (token == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return;
    }

    Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
    int userEXP = decodeToken['exp'];
    int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    if (userEXP <= timeNow) {
      await AuthService().removeToken();

      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
  }
}
