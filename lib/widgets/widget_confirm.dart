import 'package:flutter/material.dart';
import 'package:get/get.dart';

AlertDialog widgetConfirm({
  required String title,
  required String message,
  required String textButtonConfirm,
  required Function() onConfirm,
}) {
  return AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 5,
        children: [
          Container(
            width: 80,
            height: 35,
            padding: EdgeInsets.all(0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ),
          Container(
            width: 80,
            height: 35,
            padding: EdgeInsets.all(0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(0)),
              onPressed: () {
                onConfirm();
              },
              child: Text(textButtonConfirm),
            ),
          ),
        ],
      ),
    ],
  );
}
