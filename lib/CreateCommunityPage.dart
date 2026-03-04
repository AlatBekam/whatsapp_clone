import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';

class CreateCommunity extends StatelessWidget {
  const CreateCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        actions: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 19,
              color: warna.Hitam(),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          'Komunitas Baru',
            style: TextStyle(
            color: warna.Hitam(),
            fontSize: 19,
            ),
        ),
      ),
      body: Center(
        child: Text('Buat Comunity'),
      ),
    );
  }
}
