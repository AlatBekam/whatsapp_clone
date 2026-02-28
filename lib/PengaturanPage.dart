import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';    

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