import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:get/get.dart';
import 'Controllers/CommunityController.dart';

class CreateCommunity extends StatelessWidget {
  CreateCommunity({super.key});

  final CommunityController controller = Get.find();
  final TextEditingController nama = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();

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
                    'assets/logokomunitas.svg',
                    color: warna.Putih(),
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              TextField(
                controller: nama,
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
              ),

              SizedBox(height: 20),

              TextField(
                controller: deskripsi,
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: warna.buttonHijau(),
        onPressed: () async {
          if (nama.text.isNotEmpty && deskripsi.text.isNotEmpty) {
            var result = await controller.createCommunity(
              nama.text,
              deskripsi.text
            );
            if(result){
              Get.back(result: true);
            }
          } else {
            Get.snackbar(
              "Error",
              "Nama dan deskripsi harus diisi",
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
