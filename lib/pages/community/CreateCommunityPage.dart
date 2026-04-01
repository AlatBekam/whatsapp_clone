import 'package:flutter/material.dart';
import 'package:whatsapp_clone/controllers/CommunityController.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/TemplateSnackbar.dart';

class CreateCommunity extends StatefulWidget {
  CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  final CommunityController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    controller.clearForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          'Komunitas Baru',
          style: TextStyle(color: warna.Hitam(), fontSize: 19),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: warna.Putih(),
          border: Border(top: BorderSide(color: warna.AbuAbu(), width: 1)),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 45, bottom: 30),
                width: 100,
                height: 98,
                decoration: BoxDecoration(
                  color: warna.AbuAbu(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/svg/logokomunitas.svg',
                    color: warna.Putih(),
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
// FORM NAMA COMMUNITY
                    TextFormField(
                      controller: controller.nama,
                      decoration: InputDecoration(
                        hintText: 'Nama Komunitas',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama komunitas harus diisi';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),
                    
// FORM DESKRIPSI COMMUNITY
                    TextFormField(
                      controller: controller.deskripsi,
                      decoration: InputDecoration(
                        hintText: 'Deskripsi Komunitas',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Deskripsi komunitas harus diisi';
                        }
                        return null;
                      },
                    ),
                  ],
                )
              )
              
// // FORM NAMA COMMUNITY
//               TextField(
//                 controller: controller.nama,
//                 decoration: InputDecoration(
//                   hintText: 'Nama Komunitas',
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 20,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 20),
// // FORM DESKRIPSI COMMUNITY
//               TextField(
//                 controller: controller.deskripsi,
//                 decoration: InputDecoration(
//                   hintText: 'Deskripsi Komunitas',
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 40,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
            ],
          ),
        ),
      ),
// TOMBOL SUBMIT
      floatingActionButton: FloatingActionButton(
        backgroundColor: warna.buttonHijau(),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var result = await controller.createCommunity(
              controller.nama.text,
              controller.deskripsi.text,
            );
            if (result == true) {
              Get.back(result: true);
              Future.microtask(() => TemplateSnackbar.success("Community berhasil dibuat"));
            } else {
              TemplateSnackbar.error(result.toString());
            }
          }
          // if (controller.nama.text.trim().isNotEmpty &&
          //     controller.deskripsi.text.trim().isNotEmpty) {
          //   var result = await controller.createCommunity(
          //     controller.nama.text,
          //     controller.deskripsi.text,
          //   );
            
          //   print("RESULT: $result");

          //   if (result == true) {
          //     TemplateSnackbar.success("Community berhasil dibuat");
          //     Get.back(result: true);
          //   } else {
          //     TemplateSnackbar.error(result.toString());
          //   }
          // } else {
          //   TemplateSnackbar.error("Nama dan deskripsi harus diisi");
          // }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
