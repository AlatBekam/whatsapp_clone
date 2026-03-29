import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';
import 'package:whatsapp_clone/services/Theme.dart';
import 'package:whatsapp_clone/services/theme/theme.dart' hide warna;

List<dynamic> templateChat({required List<Map<String, dynamic>> listData}) =>
    List.generate(listData.length, (index) {
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
