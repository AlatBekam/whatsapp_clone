import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/status_page.dart';
import 'package:whatsapp_clone/widgets/BottomNavBar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
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
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _changeTab,
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        foregroundColor: warna.Hijau(),
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
                  // ignore: deprecated_member_use
                  color: warna.Hitam(),
                ),
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Hitam(),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsetsDirectional.fromSTEB(10, 10, 3, 5),
                  prefixIcon: Icon(Icons.search),
                  fillColor: Color.fromARGB(255, 215, 215, 215),
                  filled: true,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Chat $index"),
                  subtitle: Text("Message $index"),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text("C$index"),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {'title': 'Chat $index', 'index': index},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
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
  static Hijau() => Color(0xFF25D366);
  // static Hitam() => Colors.black;
}
