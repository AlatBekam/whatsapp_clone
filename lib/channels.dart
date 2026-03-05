import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/status_page.dart';

List<Map<String, dynamic>> channelData = [];

class channels extends StatefulWidget {
  const channels({super.key});

  @override
  State<channels> createState() => _channelsState();
}

// print(ChannelData),
class _channelsState extends State<channels> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getChannel();
  }

  @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return Center(child: Text('asd'));
  // }
  // print(channelData);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Text('Channels'),
            Row(
              spacing: 20,
              children: [
                SvgPicture.asset(
                  'assets/search.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Hitam(),
                ),
                SvgPicture.asset(
                  'assets/filter.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: warna.Hitam(),
                ),
              ],
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore Channels',
                            style: TextStyle(fontSize: ukText - 5),
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                return print('Test');
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: warna.buttonPutih(),
                                foregroundColor: warna.Hitam(),
                              ),
                              child: Text(
                                'See All',
                                style: TextStyle(fontSize: ukText - 6),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ...TemplateChannel(
                        listData: channelData.take(3).toList(),
                        onStatusTap: (item) {
                          setState(() {});
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sport', style: TextStyle(fontSize: ukText - 5)),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                return print('Test');
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: warna.buttonPutih(),
                                foregroundColor: warna.Hitam(),
                              ),
                              child: Text(
                                'See All',
                                style: TextStyle(fontSize: ukText - 6),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ...TemplateChannel(
                        listData: channelData
                            .where(
                              (tipeChannel) =>
                                  tipeChannel['channel_type'] == 'Sport',
                            )
                            .take(3)
                            .toList(),
                        onStatusTap: (item) {
                          setState(() {});
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gaming',
                            style: TextStyle(fontSize: ukText - 5),
                          ),
                          SizedBox(
                            width: 100,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                return print('Test');
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                backgroundColor: warna.buttonPutih(),
                                foregroundColor: warna.Hitam(),
                              ),
                              child: Text(
                                'See All',
                                style: TextStyle(fontSize: ukText - 6),
                              ),
                            ),
                          ),
                        ],
                      ),

                      ...TemplateChannel(
                        listData: channelData
                            .where(
                              (tipeChannel) =>
                                  tipeChannel['channel_type'] == 'Gaming',
                            )
                            .take(3)
                            .toList(),
                        onStatusTap: (item) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getChannel() async {
    var data = await ApiServices().getData('private/channels');

    if (!mounted) {
      return;
    }

    setState(() {
      channelData = List<Map<String, dynamic>>.from(data);
    });
  }
}
