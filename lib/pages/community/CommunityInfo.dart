import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/services/Theme.dart';
import 'package:get/get.dart';
import '../../../controllers/CommunityController.dart';

class KomunitasInfoPage extends StatelessWidget {
  KomunitasInfoPage({super.key});

  final CommunityController controller = Get.find();
  // final CommunityModel community = Get.arguments;

  @override
  Widget build(BuildContext context) {
    communityController.nama.text = controller.community.communityName;
    communityController.deskripsi.text = controller.community.description;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          controller.community.communityName,
          style: TextStyle(color: warna.Hitam(), fontSize: 19),
        ),
        actions: [
          PopupMenuButton(
            color: warna.Putih(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            constraints: const BoxConstraints(minWidth: 180, maxWidth: 300),
            offset: const Offset(0, 40),
            icon: SvgPicture.asset(
              'assets/svg/three-dots-vertical.svg',
              width: 19,
              color: warna.Hitam(),
            ),
            onSelected: (value) async {
              if (value == "delete") {
                await controller.deleteCommunity(
                  controller.community.communityId,
                );
                Get.back(result: true);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "delete",
                child: Text(
                  "Nonaktifkan Community",
                  style: TextStyle(
                    color: warna.Merah(),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
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
              controller: communityController.nama,
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

            const SizedBox(height: 20),

            TextField(
              controller: communityController.deskripsi,
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
                  if (communityController.nama.text.isNotEmpty &&
                      communityController.deskripsi.text.isNotEmpty) {
                    var result = await controller.updateCommunity(
                      controller.community.communityId,
                      communityController.nama.text,
                      communityController.deskripsi.text,
                    );
                    if (result) {
                      Get.back(result: true);
                    }
                  } else {
                    Get.snackbar("Error", "Nama dan deskripsi harus diisi");
                  }
                },
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
