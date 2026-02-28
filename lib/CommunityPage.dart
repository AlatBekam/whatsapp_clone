import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';

class KomunitasPage extends StatelessWidget {
    const KomunitasPage({super.key});

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
                                                builder: (context) => PengaturanPage(),
                                            ),
                                        );
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        child: Row(
                                            spacing: 15,
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
                            // widget lain untuk menampilkan komunitas
                        ],
                    )
                ],
            ),
        );
    }
}
