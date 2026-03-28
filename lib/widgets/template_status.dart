import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';

List<dynamic> templateStatus({
  required List<Map<String, dynamic>> listData,
  required Function(Map<String, dynamic>) onStatusTap,
}) => List.generate(listData.length, (index) {
  var item = listData[index];
  return ListTile(
    onTap: () => onStatusTap(item),
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
      item['StatusID'] ?? 'Channel $index',
      style: TextStyle(fontSize: ukText - 2),
    ),
    subtitle: Text(item['CreatedAt'].toString().substring(11, 19)),
    contentPadding: EdgeInsets.only(left: 5, right: 5),
  );
});
