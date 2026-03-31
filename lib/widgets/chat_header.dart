import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/chat_controller.dart';
import 'package:whatsapp_clone/Services/theme/theme.dart';

class ChatHeader extends StatelessWidget {
  final String title;
  final String? userId;
  final VoidCallback onCameraTap;

  const ChatHeader({required this.title, required this.userId, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(userId!),
                  ),
                  const SizedBox(width: 10),
                  Text(title),
                ],
              ),
          
            Row(
              children: [
                GestureDetector(
                  onTap: () => onCameraTap(),
                  child: SvgPicture.asset(
                    'assets/svg/camera.svg',
                    width: 25,
                    color: warna.Hitam(),
                  ),
                ),
                const SizedBox(width: 20),
                SvgPicture.asset(
                  'assets/svg/three-dots-vertical.svg',
                  width: 25,
                  color: warna.Hitam(),
                ),
              ],
            ),
          ],
    );
  }
}