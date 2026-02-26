import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/widgets/BottomNavBar.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Hitam(),
        foregroundColor: warna.Putih(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Text('WhatsApp'),

            Row(
              spacing: 20,
              children: [
                SvgPicture.asset(
                  'assets/camera.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Putih(),
                ),
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Putih(),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: List.generate(100, (index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 20,
                children: [
                  SvgPicture.asset(
                    'assets/person-circle.svg',
                    width: 40,
                    // ignore: deprecated_member_use
                    color: warna.Hitam(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text('Person'),
                      Text('lorem ipsum dolor sit amet'),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class warna {
  static Hitam() => Colors.black;
  static Putih() => Colors.white;
  // static Hitam() => Colors.black;
}
