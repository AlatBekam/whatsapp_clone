import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/status_page.dart';

List<dynamic> TemplateAddChannel({
  required List<Map<String, dynamic>> listData,
  required Function(Map<String, dynamic>) onStatusTap,
}) => List.generate(listData.length, (index) {
  var item = listData[index];
  return ListTile(
    leading: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: SvgPicture.asset('assets/person-circle.svg', fit: BoxFit.contain),
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

List<dynamic> TemplateChat({required List<Map<String, dynamic>> listData}) =>
    List.generate(listData.length, (index) {
      var item = listData[index];
      return ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: SvgPicture.asset(
            'assets/person-circle.svg',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          item['title'] ?? 'Channel $index',
          style: TextStyle(fontSize: ukText - 2),
        ),
        subtitle: Text('10${index}K Followers'),
        trailing: ElevatedButton(
          onPressed: () {
            print('ads');
          },
          child: Text('Follow'),
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: warna.buttonHijau(),
            foregroundColor: warna.Hitam(),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 5, right: 5),
      );
    });

List<dynamic> TemplateChannel({
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
          'assets/person-circle.svg',
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

List<dynamic> TemplateStatus({
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
      child: SvgPicture.asset('assets/person-circle.svg', fit: BoxFit.contain),
    ),
    title: Text(
      item['StatusID'] ?? 'Channel $index',
      style: TextStyle(fontSize: ukText - 2),
    ),
    subtitle: Text(item['CreatedAt'].toString().substring(11, 19)),
    contentPadding: EdgeInsets.only(left: 5, right: 5),
  );
});

List<dynamic> TemplateStatusBox({
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
