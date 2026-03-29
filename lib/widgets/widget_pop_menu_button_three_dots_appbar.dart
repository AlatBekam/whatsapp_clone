import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/controllers/auth_controller.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';

Widget widgetPopMenuButtonThreeDotsAppBar(context) {
  return PopupMenuButton<String>(
    color: Theme.of(context).colorScheme.secondary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 8,
    constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
    offset: Offset(0, 40),
    icon: SvgPicture.asset(
      'assets/svg/three-dots-vertical.svg',
      width: 19,
      color: Theme.of(context).colorScheme.onSurface,
    ),
    onSelected: (value) {
      if (value == 'Logout') {
        AlertDialog logoutDialog = AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controllerAuth.logout(true);
              },
              child: Text("Logout"),
            ),
          ],
        );

        showDialog(
          context: context,
          builder: (context) {
            return logoutDialog;
          },
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
  );
}
