import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/CommunityPage.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/chat_page.dart';
import 'package:whatsapp_clone/home.dart';
import 'package:whatsapp_clone/status_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 4, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatPage(),
          StatusPage(),
          KomunitasPage(),
          PanggilanPage(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: warna.Putih(),
          border: Border(top: BorderSide(color: warna.AbuAbu(), width: 1)),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              icon: SvgPicture.asset(
                'assets/logochat.svg',
                width: 19,
                color: warna.Hitam(),
              ),
              text: "Chat",
            ),
            Tab(
              icon: SvgPicture.asset(
                'assets/logopembaruan.svg',
                width: 20,
                color: warna.Hitam(),
              ),
              text: "Pembaruan",
            ),
            Tab(
              icon: SvgPicture.asset(
                'assets/logokomunitas.svg',
                width: 21,
                color: warna.Hitam(),
              ),
              text: "Komunitas",
            ),
            Tab(
              icon: SvgPicture.asset(
                'assets/logotelepon.svg',
                width: 20,
                color: warna.Hitam(),
              ),
              text: "Panggilan",
            ),
          ],
        ),
      ),
    );
  }
}

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const BottomNavBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: warna.Putih(),
//         border: Border(
//           top: BorderSide(
//             color: warna.AbuAbu(),
//             width: 1,
//           ),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           BottomNavItem(
//             icon: SvgPicture.asset('assets/logochat.svg', width: 19, color: warna.Hitam()),
//             label: "Chat",
//             index:0,
//             isSelected: currentIndex == 0,
//             onTap: () => onTap(0),
//           ),
//           BottomNavItem(
//             icon: SvgPicture.asset('assets/logopembaruan.svg', width: 20, color: warna.Hitam()),
//             label: "Pembaruan",
//             index:1,
//             isSelected: currentIndex == 1,
//             onTap: () => onTap(1),
//           ),
//           BottomNavItem(
//             icon: SvgPicture.asset('assets/logokomunitas.svg', width: 21, color: warna.Hitam()),
//             label: "Komunitas",
//             index:2,
//             isSelected: currentIndex == 2,
//             onTap: () => onTap(2),
//           ),
//           BottomNavItem(
//             icon: SvgPicture.asset('assets/logotelepon.svg', width: 20, color: warna.Hitam()),
//             label: "Panggilan",
//             index:3,
//             isSelected: currentIndex == 3,
//             onTap: () => onTap(3),
//           ),
//         ],
//       ),
//     );
//   }
// }

class BottomNavBarItem extends StatefulWidget {
  final Widget icon;
  final String label;

  const BottomNavBarItem({super.key, required this.icon, required this.label});

  @override
  _BottomNavBarItemState createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class BottomNavItem extends StatefulWidget {
//   final Widget icon; 
//   final String label;
//   final int index;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const BottomNavItem({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.index,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   State<BottomNavItem> createState() => _BottomNavItemState();
// }

// class _BottomNavItemState extends State<BottomNavItem> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scale;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _scale = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
  
//   void _handleTap() {
//     _controller.forward().then((_) {
//       _controller.reverse();
//     });
//     widget.onTap();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final DefaultTextStyle= TextStyle(
//       color: warna.Hitam(),
//       fontSize: 13,
//       fontWeight: FontWeight.bold,
//     );
    
//     return GestureDetector(
//       onTap: _handleTap,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: widget.isSelected ? warna.Hijau().withOpacity(0.5) : warna.Transparan(),
//               borderRadius: BorderRadius.circular(13),
//             ),
//             padding: const EdgeInsets.only(left: 18, right: 18, top: 4, bottom: 4),
//             child: ScaleTransition(
//               scale: _scale,
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.mode(
//                   widget.isSelected ? warna.HijauTua() : warna.Hitam(),
//                   BlendMode.srcIn,
//                 ),  
//                 child: widget.icon,
//               ),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             widget.label,
//             style: DefaultTextStyle,
//           )
//         ],
//       ),
//     );
//   }
// }
