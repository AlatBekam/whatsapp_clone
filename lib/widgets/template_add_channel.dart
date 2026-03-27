import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';

List<dynamic> templateAddChannel({
  required List<Map<String, dynamic>> listData,
  required Function(Map<String, dynamic>) onStatusTap,
}) => List.generate(listData.length, (index) {
  var item = listData[index];
  return ListTile(
    leading: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: SvgPicture.asset(
        'assets/svg/person-circle.svg',
        fit: BoxFit.contain,
      ),
    ),
    title: Text(
      item['channel_name'] ?? 'Channel $index',
      style: TextStyle(fontSize: ukText - 2),
    ),
    subtitle: Text(item['description'] ?? 'No subtitle'),
    trailing: ElevatedButton(
      child: Text('Follow'),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: warna.buttonHijau(),
        foregroundColor: warna.Hitam(),
      ),
      onPressed: () => onStatusTap(item),
    ),
    contentPadding: EdgeInsets.only(left: 5, right: 5),
  );
});
