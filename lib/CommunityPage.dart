import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';
import 'package:whatsapp_clone/CreateCommunityPage.dart';
import 'package:whatsapp_clone/Services/route_handler.dart';
import 'Services/api_services.dart';

class KomunitasPage extends StatefulWidget {
  const KomunitasPage({super.key});

  @override
  State<KomunitasPage> createState() => _KomunitasPageState();
}

class _KomunitasPageState extends State<KomunitasPage> {
    late Future communityFuture;

    Future getCommunity() async {
      return await ApiServices().httpGETWithToken("private/community");
    }

    @override
    void initState() {
      super.initState();
      communityFuture = getCommunity();
    }

    @override
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
                                Navigator.pushNamed(
                                    context,
                                    '/Pengaturan'
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
                                    onTap: () async {
                                        var result = await Navigator.pushNamed(
                                          context, 
                                          '/CreateCommunity'
                                        );

                                        if(result == true) {
                                          setState(() {
                                            communityFuture = getCommunity();
                                          });
                                        }
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
                            FutureBuilder(
                              future: communityFuture,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                var response = snapshot.data;
                                List data = jsonDecode(response.body);

                                List<Map<String, dynamic>> communities =
                                    data.map((e) => Map<String, dynamic>.from(e)).toList();
                                return Column(
                                  children: List.generate(communities.length, (index) {
                                    return CommunityCard(
                                      context,
                                      communities[index],
                                      () {
                                        setState(() {
                                          communityFuture = getCommunity();
                                        });
                                      }
                                    );
                                  }),
                                );
                              },
                            ),
                        ],
                    )
                ],
            ),
        );
    }
}

// FUNGSI COMMUNITY CARD
Widget CommunityCard(BuildContext context, Map<String, dynamic> community,  VoidCallback refresh) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(top: 6),
        child: 
        Material(
          color: warna.Putih(),
          child: InkWell(
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                '/CommunityInfo',
                arguments: community
              );  
              if (result == true) {
                refresh();
              }
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
                          community['community_name'],
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
                  Navigator.pushNamed(
                    context,
                    '/CreateCommunity'
                  );
                },
                child: 
                Container(
                  decoration: BoxDecoration(
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: 
                  Row(
                    spacing: 15,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengumuman',
                            style: TextStyle(
                              color: warna.Hitam(),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Name: Text',
                            style: TextStyle(
                              color: warna.AbuAbuTua(),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: warna.Putih(),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/CreateCommunity'
                  );
                },
                child: 
                Container(
                  decoration: BoxDecoration(
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: 
                  Row(
                    spacing: 15,
                    children: [
                      Container(
                        width: 35,
                        height: 33,
                        decoration: BoxDecoration(
                          color: warna.AbuAbu(),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        margin: EdgeInsets.only(left: 2),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/logokomunitas.svg',
                            color: warna.Putih(),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GRUP KE-1',
                            style: TextStyle(
                              color: warna.Hitam(),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Name: Text',
                            style: TextStyle(
                              color: warna.AbuAbuTua(),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: warna.Putih(),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/CreateCommunity',
                  );
                },
                child: 
                Container(
                  decoration: BoxDecoration(
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  child: 
                  Row(
                    spacing: 15,
                    children: [
                      Container(
                        width: 35,
                        height: 33,
                        child: Center(
                          child: Icon(
                            Icons.chevron_right,
                            color: warna.AbuAbuTua(),
                            size: 20,
                          ),
                        ),
                      ),
                      Text(
                        'Lihat Semua',
                        style: TextStyle(
                          color: warna.AbuAbuTua(),
                          fontSize: 15,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
