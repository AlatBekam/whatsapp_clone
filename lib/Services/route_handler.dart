import 'package:flutter/material.dart';
import 'package:whatsapp_clone/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => const home());

    default:
      return MaterialPageRoute(builder: (context) => const home());
  }
}
