import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:whatsapp_clone/controllers/loading_controller.dart';
import 'package:whatsapp_clone/controllers/chat_controller.dart';
import 'package:whatsapp_clone/widgets/text_field.dart';

class PreviewImage extends StatelessWidget {
  final File? image;

  PreviewImage({required this.image});

  Widget _buildImage(
    BuildContext context,
    Function(String) onImageChanged,
  ) {
    return GetBuilder<ChatController>(builder: (ctrl){
      if (ctrl.image != null) {
        print("Berhasil masuk ke preview image dengan path: ${ctrl.image!.path}");
        return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(
              ctrl.image!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                print("Error loading image: $error");
                return Center(child: Text('Error loading image: $error'));
              },
            ),
          ),

          Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ctrl.image = null;
                        onImageChanged('');
                        Get.back(); // Kembali ke chat setelah batal
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/close-X.svg',
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Row(
                        spacing: 5,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/letter-a.svg',
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 45,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/svg/color-palette.svg',
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () async {
                          //     await ctrl.sendMessage();
                          //     Get.back(); // Kembali ke chat setelah kirim
                          //   },
                          //   child: Container(
                          //     height: 45,
                          //     width: 45,
                          //     padding: EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //       color: Colors.green,
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: Icon(
                          //       Icons.send,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: Obx(() => KolomChat(
                    color: const Color.fromARGB(255, 196, 196, 196),
                    controller: chatController.messageController,
                    Sending: () async {
                      await loadingController.run(Keys.sendMessage, () async {
                        await chatController.sendMessage();
                        Get.back();
                      });
                    },
                    Loading:
                        loadingController.dataState(Keys.sendMessage) ==
                        DataState.loading,
                  ),
                  )
            )
        ],
      );
      } else {
        print("Image is null or does not exist: ${ctrl.image?.path}");
        return Center(child: Text('No image selected or image does not exist'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildImage(context, (value) {
        // Handle image change if needed
      }),
    );
  }

}