import 'package:flutter/material.dart';
    

class PengaturanPage extends StatelessWidget {
    const PengaturanPage({super.key});
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Pengaturan'),
            ),
            body: Center(
                child: Text('This is the Pengaturan Page'),
            ),
        );
    }
}