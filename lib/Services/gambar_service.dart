// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/Services/Permission.dart';
// import 'package:whatsapp_clone/controllers/chat_controller.dart';

class GambarService extends GetxController {
 static XFile? image2;
  RequestPermission requestPermission = RequestPermission();
  final picker = ImagePicker();
  Future<void> getImage() async {
    // await _requestPermission(isGallery: true);

    print("masuk ke get image");

    try {
      XFile? PickFile = await showDialog<XFile?>(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: Text("Select Image"),
          content: Text("Select image from camera or gallery"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await requestPermission.req(isGallery: true);
                final file = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                print("PickFile: $file");
                Get.back(result: file);
              },
              child: Text("Gallery"),
            ),
            TextButton(
              onPressed: () async {
                await requestPermission.req(isGallery: false);
                final file = await picker.pickImage(source: ImageSource.camera);
                print("PickFile: $file");
                Get.back(result: file);
              },
              child: Text("Camera"),
            ),
          ],
        ),
      );
      image2 = PickFile;
    } on Exception catch (e) {
      print("error bagian perizinan pada getiamge: $e");
    }
  }
}

GambarService gambarService = Get.find<GambarService>();