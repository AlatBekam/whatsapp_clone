import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/login.dart';
import 'package:whatsapp_clone/status_page.dart';

List<Map<String, dynamic>> channelData = [];

class channels extends StatefulWidget {
  const channels({super.key});

  @override
  State<channels> createState() => _channelsState();
}

// print(ChannelData),
class _channelsState extends State<channels> {
  Set<String> followedIds = {};
  List<Map<String, dynamic>> _followedChannel = globalFollowedChannel;
  List<Map<String, dynamic>> _discoverChannel = globalDiscoverChannel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getChannel();
    _getUser();
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

                      ...TemplateAddChannel(
                        listData: globalDiscoverChannel.take(4).toList(),
                        onStatusTap: (item) {
                          setState(() {
                            _followChannel(item['channel_id']);
                          });
                        },
                      ),

                      if (globalDiscoverChannel.any(
                        (item) => item['channel_type'] == 'Sport',
                      ))
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sport',
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

                      ...TemplateAddChannel(
                        listData: globalDiscoverChannel
                            .where(
                              (tipeChannel) =>
                                  tipeChannel['channel_type'] == 'Sport',
                            )
                            .take(3)
                            .toList(),
                        onStatusTap: (item) {
                          setState(() {
                            _followChannel(item['channel_id']);
                          });
                        },
                      ),

                      if (globalDiscoverChannel.any(
                        (item) => item['channel_type'] == 'Gaming',
                      ))
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

                      ...TemplateAddChannel(
                        listData: globalDiscoverChannel
                            .where(
                              (tipeChannel) =>
                                  tipeChannel['channel_type'] == 'Gaming',
                            )
                            .take(3)
                            .toList(),
                        onStatusTap: (item) {
                          setState(() {
                            _followChannel(item['channel_id']);
                          });
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

  Future<void> _followChannel(String channelID) async {
    followedIds.add(channelID);
    var dataFollow = {'followed_channels_by_id': followedIds.toList()};
    await ApiServices().updateUser(dataFollow, 'private/users');

    if (!mounted) {
      return;
    }

    print('userdata $userData');
    print('followedIDS CHANNELS.DART $followedIds');

    _splitChannel();
    _getChannel();
    _getUser();
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

  Future<void> _getUser() async {
    String? token = await authService().getToken();
    var userID;
    if (token != null) {
      Map<String, dynamic> decodeToken = JwtDecoder.decode(token);

      userID = decodeToken['id'];
    }

    var data = await ApiServices().getData('public/users/$userID');

    if (!mounted) {
      return;
    }

    setState(() {
      userData = data;
      followedIds = Set<String>.from(
        userData?['followed_channels_by_id'] ?? [],
      );
    });
    _splitChannel();
  }

  void _splitChannel() {
    _followedChannel.clear();
    _discoverChannel.clear();

    for (var a in channelData) {
      if (followedIds.contains(a['channel_id'])) {
        _followedChannel.add(a);
      } else {
        _discoverChannel.add(a);
      }
    }

    // globalDiscoverChannel.add(_discoverChannel);
    globalFollowedChannel = _followedChannel;
    setState(() {});
  }
}
