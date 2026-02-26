import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/widgets/BottomNavBar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState((){
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [
    ChatPage(),
    StatusPage(),
    KomunitasPage(),
    PanggilanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _changeTab,
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Hitam(),
        foregroundColor: warna.Putih(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Text('WhatsApp'),
            Row(
              spacing: 20,
              children: [
                SvgPicture.asset(
                  'assets/camera.svg',
                  width: 25,
                  color: warna.Putih(),
                ),
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
                  width: 25,
                  color: warna.Putih(),
                ),
              ]
            )
          ],
        )
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(100, (index) {
            return Row(
              children: [
                SvgPicture.asset(
                  'assets/person-circle.svg',
                  width: 40,
                  color: warna.Hitam(),
                ),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Person'),
                    Text('lorem ipsum dolor sit amet'),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Status Page"));
  }
}

class KomunitasPage extends StatelessWidget {
  const KomunitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Komunitas Page"));
  }
}

class PanggilanPage extends StatelessWidget {
  const PanggilanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Panggilan Page"));
  }
}

class warna {
  static Hitam() => Colors.black;
  static Putih() => Colors.white;
}
