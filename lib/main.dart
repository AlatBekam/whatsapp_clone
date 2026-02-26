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
      onGenerateRoute: router.generateRoute,
      initialRoute: "/",
    );
  }
}
