import 'package:flutter/material.dart';

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
      String? result = 'light';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      body: ListTile(
        leading: Icon(result == 'light' ? Icons.sunny : Icons.nightlight_round),
        title: Text('Tema'),
        subtitle: Text(result == 'light' ? 'Terang' : 'Gelap'),
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
                        Navigator.pop(context, result = 'light');
                        setState(() {
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.nightlight_round),
                      title: Text('Gelap'),
                      onTap: () {
                        // Ganti ke tema gelap
                        Navigator.pop(context, result = 'dark');
                        setState(() {
                        });
                      },
                    ),
                  ],
                ),
              );
            });
            // if (result != null) {
            //   setState(() {
            //     // Perbarui state dengan tema yang dipilih
            //   });
            // }

          // Navigasi ke halaman Akun
        },
      ),
    );
  }
}
