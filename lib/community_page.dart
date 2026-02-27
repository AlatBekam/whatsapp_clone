import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Text('Komunitas'),
            Row(
              spacing: 20,
              children: [
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
                  width: 25,
                  color: warna.Hitam(),
                ),
              ],
            ),
          ],
        )
      ),
      body: CommunityBody(),
    );
  }
}

class CommunityBody extends StatefulWidget {
  const CommunityBody({Key? key}) : super(key: key);

  @override
  State<CommunityBody> createState() => _CommunityBodyState();
}

class _CommunityBodyState extends State<CommunityBody> {
  // semua field dan logika yang berubah‑ubah di sini

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Komunitas Page"));
  }
}