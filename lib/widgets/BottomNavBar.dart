import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Widget _buildItem(
      {required Widget icon,
      required String label,
      required int index}) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.green : Colors.black54,
              BlendMode.srcIn,
            ),
            child: icon,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.black54,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black12),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            icon: SvgPicture.asset('assets/logochat.svg', width: 19),
            label: "Chat",
            index:0,
          ),
          _buildItem(
            icon: SvgPicture.asset('assets/logochat.svg', width: 19),
            label: "Pembaruan",
            index:1,
          ),
          _buildItem(
            icon: SvgPicture.asset('assets/logochat.svg', width: 19),
            label: "Komunitas",
            index:2,
          ),
          _buildItem(
            icon: SvgPicture.asset('assets/logochat.svg', width: 19),
            label: "Panggilan",
            index:3,
          ),
        ],
      ),
    );
  }
}