import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';
import 'package:whatsapp_clone/CreateCommunityPage.dart';

class KomunitasPage extends StatelessWidget {
    // final int IndexKomunitas;
    // final int IndexGrupFromKomunitas;

    const KomunitasPage(
      {super.key, 
      }
    );

    @override
    // State<KomunitasPage> createState() => _KomunitasPageState();
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: warna.Putih(),
                title: Text(
                    'Community',
                    style: TextStyle(
                        color: warna.Hitam(),
                        fontSize: 19,
                        ),
                ),
                actions: [
                    PopupMenuButton<String>(
                        color: warna.Putih(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 8,
                        constraints: BoxConstraints(
                            minWidth: 180,
                            maxWidth: 300,
                        ),
                        offset: Offset(0, 40),
                        icon: SvgPicture.asset(
                            'assets/three-dots-vertical.svg',
                            width: 19,
                            color: warna.Hitam(),
                        ),
                        onSelected: (value) {
                            if (value == 'Pengaturan') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PengaturanPage(),
                                    ),
                                );
                            }
                        },
                        itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 'Pengaturan',
                                child: Text('Pengaturan', 
                                style: TextStyle(
                                    color: warna.Hitam(),
                                    fontWeight: FontWeight.w400,
                                    )
                                ),
                            ),
                        ]
                    )
                ],
            ),

            body: ListView(
                children: [
                    Column(
                        children: [
                            Material(
                                color: warna.Putih(),
                                child: InkWell(
                                    onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => CreateCommunity(),
                                            ),
                                        );
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        child: Row(
                                            spacing: 15,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: warna.AbuAbu(),
                                                      borderRadius: BorderRadius.circular(9),
                                                    ),
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                        'assets/logokomunitas.svg',
                                                        color: warna.Putih(),
                                                        width: 25,
                                                        height: 25,
                                                      )
                                                    )
                                                  ),
                                                  Positioned(
                                                    bottom: -1,
                                                    right: -1,
                                                    child: 
                                                      Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: warna.Hijau(),
                                                        borderRadius: BorderRadius.circular(20),
                                                        border: Border.all(
                                                          color: warna.Putih(),
                                                          width: 1.5,
                                                        )
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 15,
                                                        color: warna.Putih(),
                                                      ), 
                                                    ),
                                                  )
                                                ]
                                              ),
                                              Text(
                                                'New Community',
                                                style: TextStyle(
                                                  color: warna.Hitam(),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                        ),
                                    ),
                                )
                            ),
                            CommunityCard(context),
                        ],
                    )
                ],
            ),
        );
    }
}

// FUNGSI COMMUNITY CARD
Widget CommunityCard(BuildContext context) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 6),
        child: 
        Material(
          color: warna.Putih(),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCommunity(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: warna.AbuAbu(),
                    width: 1
                  )
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      spacing: 15,
                      children: [
                        Container(
                          child: Container(
                            width: 40,
                            height: 38,
                            decoration: BoxDecoration(
                              color: warna.AbuAbu(),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/logokomunitas.svg',
                                color: warna.Putih(),
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'COMMUNITY KE-1',
                          style: TextStyle(
                            color: warna.Hitam(),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              color: warna.Putih(),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute
                      (builder: (context) => CreateCommunity()
                    ),
                  );
                },
                child: 
                Container( //HARUS MASUK
                  decoration: BoxDecoration(
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: 
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 33,
                        decoration: BoxDecoration(
                          color: warna.Hijau(),
                          borderRadius: BorderRadius.circular(9)
                        ),
                        margin: EdgeInsets.only(left: 2),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/speaker.svg',
                            color: warna.HijauTua(),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      // CONTAINER
                    ],
                  ),
                ),
              ),
            ),
            Container(), //ISINYA ROW UNTUK PENGUMUMAN
          ],
        ),
      )
    ],
  );
}
