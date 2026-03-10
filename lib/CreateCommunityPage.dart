import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

class CreateCommunity extends StatelessWidget {
  CreateCommunity({super.key});

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

            var response = await ApiServices().httpPOSTWithToken(
              apiUrl: "private/community",
              data: {
                "community_name": nama.text,
                "description": deskripsi.text,
                "announcement_group_id": null,
              }
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
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
