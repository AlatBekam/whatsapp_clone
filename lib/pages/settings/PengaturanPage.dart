import 'package:flutter/material.dart';
import 'package:whatsapp_clone/main.dart';

class PengaturanPage extends StatefulWidget {
  final Function(AppTheme) onThemeChanged;
  final AppTheme currentTheme;

  const PengaturanPage({super.key, required this.onThemeChanged, required this.currentTheme});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
      // String? result = 'light';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      body: ListTile(
        leading: Icon(
          switch (widget.currentTheme) {
            AppTheme.Light => Icons.sunny,
            AppTheme.Dark => Icons.nightlight_round,
            AppTheme.Default => Icons.settings_backup_restore,
          },),
        title: Text('Tema'),
        subtitle: Text(
          switch (widget.currentTheme) {
            AppTheme.Light => 'Terang',
            AppTheme.Dark => 'Gelap',
            AppTheme.Default => 'Default',
          },),
        onTap: () async {
          final result = await showDialog(
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
                        Navigator.pop(context, AppTheme.Light);
                        setState(() {
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.nightlight_round),
                      title: Text('Gelap'),
                      onTap: () {
                        // Ganti ke tema gelap
                        Navigator.pop(context, AppTheme.Dark);
                        setState(() {
                        });
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_backup_restore),
                      title: Text('Default'),
                      onTap: () {
                        // Ganti ke tema default
                        Navigator.pop(context, AppTheme.Default);
                        setState(() {
                        });
                      },
                    ),
                  ],
                ),
              );
            });
            if (result != null) {
              widget.onThemeChanged(result);
              setState(() {
              });
            }

          // Navigasi ke halaman Akun
        },
      ),
    );
  }
}
