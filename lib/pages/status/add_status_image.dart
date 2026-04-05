import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/status_controller.dart';

Widget addStatusImage(
  BuildContext context,
  TextEditingController controller,
  Function(String) onChanged,
) {
  return GetBuilder<ControllerStatus>(
    builder: (ctrl) {
      if (ctrl.image == null) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await ctrl.getImage(isGallery: false);
                      if (success) {
                        onChanged("camera_selected");
                      }
                    },
                    child: Text("Select Image from Camera"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      bool success = await ctrl.getImage(isGallery: true);
                      if (success) {
                        onChanged("image_selected");
                      }
                    },
                    child: Text("Select Image from Gallery"),
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.fromLTRB(15, 45, 0, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/close-X.svg',
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(ctrl.image!),
                  fit: BoxFit.contain,
                ),
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
                        onChanged("");
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    },
  );

  // return GetBuilder<ControllerStatus>(
  //   builder: (ctrl) {
  //     if (ctrl.image == null) {
  //       return Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         spacing: 5,
  //         children: [
  //           ElevatedButton(
  //             onPressed: () async {
  //               bool success = await ctrl.getImage(isGallery: false);
  //               if (success) {
  //                 onChanged("camera_selected");
  //               }
  //             },
  //             child: Text("Select Image from Camera"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               bool success = await ctrl.getImage(isGallery: true);
  //               if (success) {
  //                 onChanged("image_selected");
  //               }
  //             },
  //             child: Text("Select Image from Gallery"),
  //           ),
  //         ],
  //       );
  //     } else {
  //       return Stack(
  //         children: [
  //           Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: MediaQuery.of(context).size.height,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: FileImage(ctrl.image!),
  //                 fit: BoxFit.contain,
  //               ),
  //             ),
  //           ),

  //           Align(
  //             alignment: Alignment.topCenter,
  //             child: SizedBox(
  //               height: 130,
  //               width: MediaQuery.of(context).size.width,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       ctrl.image = null;
  //                       onChanged("");
  //                     },
  //                     child: Container(
  //                       height: 45,
  //                       width: 45,
  //                       margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
  //                       padding: EdgeInsets.all(10),
  //                       decoration: BoxDecoration(
  //                         color: Theme.of(
  //                           context,
  //                         ).colorScheme.secondaryContainer,
  //                         shape: BoxShape.circle,
  //                       ),
  //                       child: SvgPicture.asset(
  //                         'assets/svg/close-X.svg',
  //                         color: Theme.of(context).colorScheme.onSecondary,
  //                       ),
  //                     ),
  //                   ),

  //                   Container(
  //                     margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
  //                     child: Row(
  //                       spacing: 5,
  //                       children: [
  //                         Container(
  //                           height: 45,
  //                           width: 45,
  //                           padding: EdgeInsets.all(10),
  //                           decoration: BoxDecoration(
  //                             color: Theme.of(
  //                               context,
  //                             ).colorScheme.secondaryContainer,
  //                             shape: BoxShape.circle,
  //                           ),
  //                           child: SvgPicture.asset(
  //                             'assets/svg/letter-a.svg',
  //                             color: Theme.of(context).colorScheme.onSecondary,
  //                           ),
  //                         ),
  //                         Container(
  //                           height: 45,
  //                           width: 45,
  //                           padding: EdgeInsets.all(10),
  //                           decoration: BoxDecoration(
  //                             color: Theme.of(
  //                               context,
  //                             ).colorScheme.secondaryContainer,
  //                             shape: BoxShape.circle,
  //                           ),
  //                           child: SvgPicture.asset(
  //                             'assets/svg/color-palette.svg',
  //                             color: Theme.of(context).colorScheme.onSecondary,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     }
  //   },
  // );
}
