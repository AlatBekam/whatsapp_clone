import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Calling.dart';
import 'package:whatsapp_clone/status_page.dart';
import 'package:whatsapp_clone/login.dart';
import 'package:whatsapp_clone/widgets/BottomNavBar.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/CommunityPage.dart';

Map<String, dynamic> dummyJsonData = {
  "data": [
    {"title": "Alice", "subtitle": "Hey there!"},
    {"title": "Bob", "subtitle": "What's up?"},
    {"title": "Charlie", "subtitle": "Let's catch up soon."},
  ],
};

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
    Calling(),
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

Widget widgetitemlist({required List<Map<String, dynamic>> listData}) =>
    ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, index) {
        var item = listData[index];
        return ListTile(
          title: Text(item['title'] ?? "Chat $index"),
          subtitle: Text(item['subtitle'] ?? "Message $index"),
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text("C$index"),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/chat',
              arguments: {
                'title': item['title'] ?? "Chat $index",
                'index': index,
              },
            );
          },
        );
      },
    );

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<TabModel> children = [
    TabModel(
      title: "Chat",
      widget: widgetitemlist(
        listData: [
          {'title': 'Alice', 'subtitle': 'Hey there!'},
          {'title': 'Bob', 'subtitle': 'What\'s up?'},
          {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
        ],
      ),
    ),
    TabModel(
      title: "Status",
      widget: widgetitemlist(
        listData: [
          {'title': 'Alice', 'subtitle': 'Hey there!'},
          {'title': 'Bob', 'subtitle': 'What\'s up?'},
          {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
        ],
      ),
    ),
    TabModel(
      title: "Komunitas",
      widget: widgetitemlist(
        listData: [
          {'title': 'Alice', 'subtitle': 'Hey there!'},
          {'title': 'Bob', 'subtitle': 'What\'s up?'},
          {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
        ],
      ),
    ),
    TabModel(
      title: "Panggilan",
      widget: widgetitemlist(
        listData: [
          {'title': 'Alice', 'subtitle': 'Hey there!'},
          {'title': 'Bob', 'subtitle': 'What\'s up?'},
          {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

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
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            color: warna.Merah(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: 150,
            ),
            offset: Offset(0, 40),
            icon: SvgPicture.asset(
              'assets/three-dots-vertical.svg',
              width: 19,
              color: warna.Hitam(),
            ),
            onSelected: (value) {
              if (value == 'Logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Login(),
                  ),
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Logout',
                child: Center(
                  child:
                    Text('Logout', 
                      style: TextStyle(
                        color: warna.Putih(),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                )
              ),
            ]
          )
        ],

        bottom: TabBar(
          tabs: children.map<Widget>((child) {
            return Tab(text: child.title);
          }).toList(),
          controller: _tabController,
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: children.map<Widget>((child) {
          return child.widget;
        }).toList(),
      ),
    );
  }
}

// class PanggilanPage extends StatelessWidget {
//   const PanggilanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("Panggilan Page"));
//   }
// }

class TabModel {
  final String title;
  final Widget widget;

  TabModel({required this.title, required this.widget});
}
