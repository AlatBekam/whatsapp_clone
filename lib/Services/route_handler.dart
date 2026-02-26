import 'package:flutter/material.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const home());

    case '/splashScreen':
      return MaterialPageRoute(builder: (context) => SplashScreen());

    default:
      return MaterialPageRoute(builder: (context) => const home());
  }
}
