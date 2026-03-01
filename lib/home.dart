import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/chat_page.dart';
import 'package:whatsapp_clone/status_page.dart';
import 'package:whatsapp_clone/widgets/BottomNavBar.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/CommunityPage.dart';

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
    // ChatPage(),
    StatusPage(),
    StatusPage(),
    KomunitasPage(),
    PanggilanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavBar();
    // return Scaffold(
    //   body: IndexedStack(index: _currentIndex, children: _pages),

    //   bottomNavigationBar: BottomNavBar(),
    //   // bottomNavigationBar: BottomNavBar(
    //   //   currentIndex: _currentIndex,
    //   //   onTap: _changeTab,
    //   // ),
    // );
  }
}

// Widget widgetitemlist({required List<Map<String, dynamic>> listData}) =>
//     ListView.builder(
//       itemCount: listData.length,
//       itemBuilder: (context, index) {
//         var item = listData[index];
//         return ListTile(
//           title: Text(item['title'] ?? "Chat $index"),
//           subtitle: Text(item['subtitle'] ?? "Message $index"),
//           leading: CircleAvatar(
//             backgroundColor: Colors.green,
//             child: Text("C$index"),
//           ),
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               '/chat',
//               arguments: {
//                 'title': item['title'] ?? "Chat $index",
//                 'index': index,
//               },
//             );
//           },
//         );
//       },
//     );

class PanggilanPage extends StatelessWidget {
  const PanggilanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Panggilan Page"));
  }
}

class TabModel {
  final String title;
  final Widget widget;

  TabModel({required this.title, required this.widget});
}
