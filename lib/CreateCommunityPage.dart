import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/PengaturanPage.dart';

class CreateCommunity extends StatelessWidget {
  const CreateCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          'Komunitas Baru',
            style: TextStyle(
            color: warna.Hitam(),
            fontSize: 19,
            ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: warna.Putih(),
          border: Border(
            top: BorderSide(
              color: warna.AbuAbu(),
              width: 1
            )
          )
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
                  )
                ),
              ),
              TextField(
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
                )
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: warna.buttonHijau(),
        onPressed: () async {
          // TODO: Kirim / Simpan data ke database di sini
          // Contoh:
          // await simpanKeDatabase();
          //
          // atau kirim data ke halaman sebelumnya:
          // Navigator.pop(context, {
          //   'nama': namaController.text,
          //   'deskripsi': deskripsiController.text,
          // });

          // Untuk sekarang hanya kembali ke halaman sebelumnya
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
