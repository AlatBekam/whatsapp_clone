import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/auth_controller.dart';
import 'package:whatsapp_clone/services/route_handler.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';
import 'package:whatsapp_clone/widgets/widget_confirm.dart';

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
        AlertDialog logoutDialog = widgetConfirm(
          title: "Logout",
          message: "Are you sure you want to logout?",
          textButtonConfirm: "Logout",
          onConfirm: () {
            controllerAuth.logout(true);
          },
        );
        // AlertDialog logoutDialog = AlertDialog(
        //   title: Text("Logout"),
        //   content: Text("Are you sure you want to logout?"),
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //       child: Text("Cancel"),
        //     ),
        //     TextButton(
        //       onPressed: () {
        //         controllerAuth.logout(true);
        //       },
        //       child: Text("Logout"),
        //     ),
        //   ],
        // );

        showDialog(
          context: context,
          builder: (context) {
            return logoutDialog;
          },
        );
      }

      if (value == 'Settings') {
        Get.toNamed(Routes.settings);
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'Logout',
        child: Center(
          child: Text(
            'Logout',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      PopupMenuItem(
        value: 'Settings',
        child: Center(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
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
