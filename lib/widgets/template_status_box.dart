import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';

List<dynamic> templateStatusBox({
  required List<Map<String, dynamic>> listData,
  required Function(Map<String, dynamic>) onStatusTap,
}) => List.generate(listData.length, (index) {
  var item = listData[index];
  return GestureDetector(
    onTap: () => onStatusTap(item),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),
          child: Container(
            margin: EdgeInsets.all(3),
            width: 120,
            color: warna.Hijau(),
          ),
        ),

        Positioned(
          // top: 13,
          // left: 13,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: warna.Putih(),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  item['StatusID'] ?? 'Title $index',
                  style: TextStyle(color: warna.Putih(), fontSize: ukText - 5),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
});
