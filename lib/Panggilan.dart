import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Panggilan extends StatelessWidget {
  const Panggilan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              "assets/icons/search.svg",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(
              "assets/icons/three-dots-vertical.svg",
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
      body: Center(
        child: Text("Panggilan Page"),
      ),
    );
  }
}