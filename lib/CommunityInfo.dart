import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:get/get.dart';
import '../Models/CommunityModel.dart';
import '../Controllers/CommunityController.dart';

class KomunitasInfoPage extends StatelessWidget {
  KomunitasInfoPage({super.key});

  final CommunityController controller = Get.find();
  final CommunityModel community = Get.arguments;
  final TextEditingController nama = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nama.text = community.communityName;
    deskripsi.text = community.description;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          community.communityName,
          style: TextStyle(
            color: warna.Hitam(),
            fontSize: 19,
          ),
        ),
        actions: [
          PopupMenuButton(
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
              if(value == "delete"){
                await controller.deleteCommunity(
                  community.communityId
                );
                Get.back(result:true);
              }
            },
            itemBuilder: (context)=>[
              PopupMenuItem(
                value: "delete",
                child: Text(
                  "Nonaktifkan Community",
                  style: TextStyle(color: warna.Merah(), fontWeight: FontWeight.w400),
                ),
              )
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

            const SizedBox(height:20),

            Text(
              "Deskripsi",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: warna.Hitam(),
              ),
            ),

            const SizedBox(height:20),

            TextField(
              controller: deskripsi,
              maxLines:3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height:30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: warna.Hijau(),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if(nama.text.isNotEmpty && deskripsi.text.isNotEmpty) {
                    var result = await controller.updateCommunity(
                      community.communityId,
                      nama.text,
                      deskripsi.text,
                    );
                    if (result) {
                      Get.back(result: true);
                    }
                  } else {
                    Get.snackbar(
                      "Error",
                      "Nama dan deskripsi harus diisi",
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
            ),
          ],
        ),
      ),
    );
  }
}