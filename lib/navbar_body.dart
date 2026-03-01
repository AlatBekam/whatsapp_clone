import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/Theme.dart';

class NavbarBody extends StatelessWidget {
  final String title;
  final int index;
  /// Called when one of the items is tapped. The argument is the
  /// zero‑based index of the item that was pressed.
  final ValueChanged<int>? onTap;

  const NavbarBody({
    super.key,
    required this.title,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(10, (i) {
            // wrap each element with a gesture detector/inkwell so it can
            // respond to taps.
            return GestureDetector(
              onTap: () {
                if (onTap != null) onTap!(i);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                // decoration: BoxDecoration(
                //   color: i == index ? warna.Hijau().withOpacity(0.2) : warna.Putih(),
                //   borderRadius: BorderRadius.circular(20),
                //   border: Border.all(color: i == index ? warna.Hijau() :Colors.grey),
                // ),
                child: Chip(
                label: Text(
                  'Item $i',
                  style: TextStyle(
                    color: i == index ? Colors.green[600] : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: i == index ? warna.Hijau() : Colors.grey,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                labelPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                )
              ),
            );
          }),
        ),
      )
      
      
    );
  }
}