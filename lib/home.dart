import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Calling.dart';
import 'package:whatsapp_clone/status_page.dart';
import 'package:whatsapp_clone/widgets/BottomNavBar.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

List<Map<String, dynamic>> datauser = [];
final ApiServices api = ApiServices();

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0;
  String? currentUserId;

  @override
  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserId();
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

   Future<String?> getUserId() async {
    return await ApiServices().dptToken();
  }

  Future<void> loadUserId() async {
    currentUserId = await getUserId();
    setState(() {
      
    });
  }
  }

Widget widgetitemlist({
  required List<Map<String, dynamic>> datauser,
  required String currentUserId,
}) {
  var filteredUsers =
      datauser.where((user) => user['id'].toString() != currentUserId).toList();

  return ListView.builder(
    itemCount: filteredUsers.length,
    itemBuilder: (context, index) {
      var item = filteredUsers[index];

      return ListTile(
        title: Text(item['name']?.toString() ?? 'id'),
        subtitle: Text(item['subtitle']?.toString() ?? "Message $index"),
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text("C$index"),
        ),
        onTap: () async {
          // Get or create chat first to get chat_id
          final userId = item['id']?.toString() ?? "0";
          final chatData = await ApiServices().getOrCreateChat(userId);
          
          String? chatId;
          if (chatData != null) {
            // Try to get chat_id from response - adjust based on your API response structure
            chatId = chatData['chat_id']?.toString() ?? 
                     chatData['id']?.toString() ??
                     chatData['id_chat']?.toString();
            print("Got chat_id: $chatId from chatData: $chatData");
          }
          
          if (!context.mounted) return;
          Navigator.pushNamed(
            context,
            '/chat',
            arguments: {
              'title': item['name']?.toString() ?? "Chat",
              'user_id': userId,
              'chat_id': chatId,
            },
          );
        },
      );
    },
  );
}




// Widget widgetitemlist({required List<Map<String, dynamic>> datauser}) => 
//     ListView.builder(
//       itemCount: datauser.length,
//       itemBuilder: (context, index) {
//         var item = datauser[index];
//         return ListTile(
//           title: Text(item['name']?.toString() ?? 'id'),
//           subtitle: Text(item['subtitle']?.toString() ?? "Message $index"),
//           leading: CircleAvatar(
//             backgroundColor: Colors.green,
//             child: Text("C$index"),
//           ),
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               '/chat',
//               arguments: {
//                 'title': item['name']?.toString() ?? "Chat",
//                 'user_id': item['id']?.toString() ?? "0",
//               },
//             );
//           },
//         );
//       },
//     );

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<void> _getUser() async {
    try {
      final data = await api.httpGET('public/users');
      print("DATA: $data");
      setState(() {
        datauser = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }
  // with SingleTickerProviderStateMixin {
  // TabController? _tabController;
  // List<TabModel> children = [
  //   TabModel(
  //     title: "Chat",
  //     widget: widgetitemlist(
  //       listData: [
  //         {'title': 'Alice', 'subtitle': 'Hey there!'},
  //         {'title': 'Bob', 'subtitle': 'What\'s up?'},
  //         {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
  //       ],
  //     ),
  //   ),
  //   TabModel(
  //     title: "Status",
  //     widget: widgetitemlist(
  //       listData: [
  //         {'title': 'Alice', 'subtitle': 'Hey there!'},
  //         {'title': 'Bob', 'subtitle': 'What\'s up?'},
  //         {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
  //       ],
  //     ),
  //   ),
  //   TabModel(
  //     title: "Komunitas",
  //     widget: widgetitemlist(
  //       listData: [
  //         {'title': 'Alice', 'subtitle': 'Hey there!'},
  //         {'title': 'Bob', 'subtitle': 'What\'s up?'},
  //         {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
  //       ],
  //     ),
  //   ),
  //   TabModel(
  //     title: "Panggilan",
  //     widget: widgetitemlist(
  //       listData: [
  //         {'title': 'Alice', 'subtitle': 'Hey there!'},
  //         {'title': 'Bob', 'subtitle': 'What\'s up?'},
  //         {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
  //       ],
  //     ),
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _getUser();
    _getCurrentUserId();
    // _tabController = TabController(length: children.length, vsync: this);
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
            constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
            offset: Offset(0, 40),
            icon: SvgPicture.asset(
              'assets/three-dots-vertical.svg',
              width: 19,
              color: warna.Hitam(),
            ),
            onSelected: (value) {
              if (value == 'Logout') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Logout',
                child: Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: warna.Putih(),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],

        //   bottom: TabBar(
        //     tabs: children.map<Widget>((child) {
        //       return Tab(text: child.title);
        //     }).toList(),
        //     controller: _tabController,
        //   ),
        // ),

        // body: TabBarView(
        //   controller: _tabController,
        //   children: children.map<Widget>((child) {
        //     return child.widget;
        //   }).toList(),
      ),
      body: widgetitemlist(datauser: datauser, currentUserId: currentUserId ?? ""),
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
