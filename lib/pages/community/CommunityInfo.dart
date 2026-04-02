import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';
import 'package:get/get.dart';
import '../../../controllers/CommunityController.dart';
import '../../widgets/TemplateSnackbar.dart';
import '../../widgets/enum_status.dart';
import '../../widgets/widget_loading_transparent.dart';
import 'dart:io';
import '../../../Services/gambar_service.dart';

class KomunitasInfoPage extends StatelessWidget {
  KomunitasInfoPage({super.key});

  final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    communityController.nama.text = communityController.community.communityName;
    communityController.deskripsi.text = communityController.community.description;
      return Obx(() {
        if (communityController.status.value == Status.loading) {
          return Scaffold(
            body: widgetLoadingTransparent(context)
          );
        }
        if (communityController.status.value == Status.error) {
          return Center(
            child: Text("Gagal memuat data"),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: warna.Putih(),
            title: Text(
              communityController.community.communityName,
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
                    Get.defaultDialog(
                      title: "Konfirmasi",
                      middleText: "Apakah kamu yakin ingin menonaktifkan community ini?",
                      textCancel: "Batal",
                      textConfirm: "Nonaktifkan",
                      confirmTextColor: Colors.white,
                      buttonColor: warna.Merah(),
                      onConfirm: () async {
                        Get.back();

                        var result = await communityController.deleteCommunity(
                          communityController.community.communityId,
                        );

                        if (result == true) {
                          Get.back(result: true); // kembali dari halaman info
                          TemplateSnackbar.success("Community berhasil dinonaktifkan");
                        } else {
                          TemplateSnackbar.error(result.toString());
                        }
                      },
                    );
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
// AVATAR
                    Center(
                      child: 
                      GestureDetector(
                        onTap: () async {
                          await gambarService.getImage();
                        },
                        child: Stack(
                          children: [
                            Obx(() {
                              final selectedImage = gambarService.selectedImage.value;
                              final imageUrl =
                                  communityController.community.communityImageUrl;

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: selectedImage != null
                                    ? Image.file(
                                        File(selectedImage.path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : (imageUrl != null && imageUrl.isNotEmpty)
                                        ? Image.network(
                                            imageUrl,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            color: warna.AbuAbu(),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/svg/logokomunitas.svg',
                                                width: 70,
                                                height: 70,
                                                color: warna.Putih(),
                                              ),
                                            ),
                                          ),
                              );
                            }),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 14,
                                child: Icon(Icons.camera_alt, size: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nama Community",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warna.Hitam(),
                            ),
                          ),
// FORM NAMA COMMUNITY
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: communityController.nama,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Nama komunitas harus diisi';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
// FORM DESKRIPSI COMMUNITY
                          Text(
                            "Deskripsi",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: warna.Hitam(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                          controller: communityController.deskripsi,
                          maxLines: 3,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Deskripsi komunitas harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                      ]
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warna.Hijau(),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed:communityController.status.value == Status.loading ? null : () async {
                        if (_formKey.currentState!.validate()) {
                          var result = await communityController.updateCommunity(
                            communityController.community.communityId,
                            communityController.nama.text,
                            communityController.deskripsi.text,
                          );
                          if (result == true) {
                            Get.back(result: true);
                            Future.microtask(() => TemplateSnackbar.success("Community berhasil diperbarui"));
                          } else {
                            TemplateSnackbar.error(result.toString());
                          }
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
    });
  }
}
