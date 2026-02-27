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
            Text('Komunitas',
              style: TextStyle(
                color: warna.Hitam(),
                fontSize: 20,
              ),
            ),
            Row(
              spacing: 20,
              children: [
                PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(
                    'assets/three-dots-vertical.svg',
                    width: 19,  
                    color: warna.Hitam(),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          SizedBox(width: 5, height: 10),
                          Padding(padding: EdgeInsets.only(left: 2)),
                          Text('Pengaturan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  onSelected: (v) {
                    if (v == 1) {
                      // Aksi ketika "Pengaturan" dipilih
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: warna.Putih(),
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