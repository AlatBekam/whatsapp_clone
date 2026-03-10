import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'CreateCommunityPage.dart';

class KomunitasInfoPage extends StatefulWidget {
    const KomunitasInfoPage({super.key});

    @override
    State<KomunitasInfoPage> createState() => _KomunitasInfoPageState();
}

class _KomunitasInfoPageState extends State<KomunitasInfoPage> {

    // controller untuk edit data
    final TextEditingController nama = TextEditingController();
    final TextEditingController deskripsi = TextEditingController();

    // menyimpan data community yang dikirim dari halaman sebelumnya
    Map community = {};

    bool isLoaded = false;

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        if (!isLoaded) {
            final args = ModalRoute.of(context)!.settings.arguments;
            print(args);
            if (args != null && args is Map<String, dynamic>) {
            community = args;  

            print("COMMUNITY DATA:");
            print(community);
            
            nama.text = community["community_name"] ?? "";
            deskripsi.text = community["description"] ?? "";
            }
            isLoaded = true;
        }
    }

  @override
  Widget build(BuildContext context) {

    if (!isLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          community["community_name"]?.toString() ?? "",
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
            constraints: const BoxConstraints(
              minWidth: 180,
              maxWidth: 300,
            ),
            offset: const Offset(0, 40),
            icon: SvgPicture.asset(
              'assets/three-dots-vertical.svg',
              width: 19,
              color: warna.Hitam(),
            ),
            onSelected: (value) async {
              if (value == 'delete') {
                  await ApiServices().httpDELETEWithToken(
                    "private/community/${community["community_id"]}"
                  );

                  Navigator.pop(context, true);
              }
            },
            
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Nonaktifkan Community',
                  style: TextStyle(
                    color: warna.Merah(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )
        ],
      ),

      body: Container(
        color: warna.Putih(),
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            Text(
              "Nama Community",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: warna.Hitam(),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nama,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Deskripsi",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: warna.Hitam(),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: deskripsi,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: warna.Hijau(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if(nama.text.isNotEmpty && deskripsi.text.isNotEmpty) {
                    var response = await ApiServices().httpPUTWithToken(
                      apiUrl: "private/community/${community["community_id"]}",
                      data: {
                        "community_name": nama.text,
                        "description": deskripsi.text,
                      },
                    );
                    if (response.statusCode == 200) {
                      Navigator.pop(context, true);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Nama dan deskripsi harus diisi"))
                    );
                  }
                },
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}