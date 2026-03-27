import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';

List<dynamic> templateChannel({
  required List<Map<String, dynamic>> listData,
  required Function(Map<String, dynamic>) onStatusTap,
}) => List.generate(listData.length, (index) {
  var item = listData[index];
  return GestureDetector(
    onLongPress: () => onStatusTap(item),
    child: ListTile(
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
      contentPadding: EdgeInsets.only(left: 5, right: 5),
    ),
  );
});
