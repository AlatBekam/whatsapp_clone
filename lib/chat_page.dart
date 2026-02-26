import 'package:flutter/material.dart';

class Chatpage extends StatelessWidget {
  final String title;
  final int index;

  const Chatpage({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the chat page for chat $index'),
      ),
    );
  }
}