import 'package:flutter/material.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      body: ListTile(
        leading: Icon(Icons.sunny),
        title: Text('Tema'),
        subtitle: Text('Terang'),
        onTap: () {
          showDialog(
            context: context, builder: (context) {
              return AlertDialog(
                title: Text('Pilih Tema'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.sunny),
                      title: Text('Terang'),
                      onTap: () {
                        // Ganti ke tema terang
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.nightlight_round),
                      title: Text('Gelap'),
                      onTap: () {
                        // Ganti ke tema gelap
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            });
          // Navigasi ke halaman Akun
        },
      ),
    );
  }
}
