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

  Widget _buildItem({required Widget icon, required String label, required int index, TextStyle? style}) {
    final bool isSelected = currentIndex == index;
    final DefaultTextStyle = TextStyle(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 13,
      fontWeight: FontWeight.bold,
    );

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected ? Colors.green : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            padding: const EdgeInsets.only(bottom: 4),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.green : const Color.fromARGB(255, 0, 0, 0),
                BlendMode.srcIn,
              ),
              child: icon,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: DefaultTextStyle.merge(style),
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
        border: Border(
          top: BorderSide(
            color: const Color.fromARGB(255, 200, 200, 200),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            icon: SvgPicture.asset('assets/logochat.svg', width: 19, color: const Color.fromARGB(255, 0, 0, 0)),
            label: "Chat",
            index:0,
          ),
          _buildItem(
            icon: SvgPicture.asset('assets/logopembaruan.svg', width: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            label: "Pembaruan",
            index:1,
          ),
          _buildItem(
            icon: SvgPicture.asset('assets/logokomunitas.svg', width: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            label: "Komunitas",
            index:2,
          ),
          _buildItem(
            icon: SvgPicture.asset('assets/logotelepon.svg', width: 20, color: const Color.fromARGB(255, 0, 0, 0)),
            label: "Panggilan",
            index:3,
          ),
        ],
      ),
    );
  }
}