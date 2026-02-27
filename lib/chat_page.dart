import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';

class Chatpage extends StatelessWidget {
  final String title;
  final int index;

  const Chatpage({super.key, required this.title, required this.index});
  
  get children => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('C$index'),
                ),
                SizedBox(width: 10),
                Text(title),
              ],
            ),
            Row(
              spacing: 20,
              children: [
                SvgPicture.asset(
                  'assets/camera.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Hitam(),
                ),
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Hitam(),
                ),
              ],
            ),
          ],
        )
      ),
      body: Center(
        child: Text('This is the chat page for chat $index'),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
              hintText: 'Type a message',
              prefixIcon: Icon(Icons.emoji_emotions),
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: warna.Hijau(),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(Icons.send),
        color: Colors.white,
      ),
    ),
  ],
        ),
      ),    
    );
  }
}