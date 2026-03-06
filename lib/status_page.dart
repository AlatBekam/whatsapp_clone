import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/Services/data_dummy.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

double ukText = 21;
List<Map<String, dynamic>> channelData = [];
List<Map<String, dynamic>> statusData = [];
List<Map<String, dynamic>> viewedStatusData = [];
List<Map<String, dynamic>> globalFollowedChannel = [];
List<Map<String, dynamic>> globalDiscoverChannel = [];
Map<String, dynamic>? userData = {};

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final List<Map<String, dynamic>> _statusData = [];
  final List<Map<String, dynamic>> _followedChannel = [];
  final List<Map<String, dynamic>> _discoverChannel = [];
  final List<Map<String, dynamic>> _nonViewedStatus = [];
  final List<Map<String, dynamic>> _viewedStatus = [];
  Set<String> followedIds = {};
  Set<String> viewedIds = {};

  @override
  void initState() {
    super.initState();
    _statusData.addAll(StatusDummyData());
    _getChannel();
    _getUser();
    _getStatus();
    _getViewedStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          children: [
            Text('Updates'),
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
                  'assets/three-dots-vertical.svg',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: <Widget>[
                      Text('Status', style: TextStyle(fontSize: ukText)),

                      if ((userData?['followed_channels_by_id'] as List?)
                              ?.isNotEmpty ??
                          false)
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...TemplateStatusBox(
                                    listData: _nonViewedStatus,
                                    onStatusTap: (item) {
                                      _viewStatus(item['StatusID']);
                                    },
                                  ),

                                  Text('pisah'),

                                  ...TemplateStatusBox(
                                    listData: _viewedStatus,
                                    onStatusTap: (item) {
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Channels',
                                  style: TextStyle(fontSize: ukText),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                        context,
                                        "/channels",
                                      );
                                      _getUser();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      backgroundColor: warna.buttonPutih(),
                                      foregroundColor: warna.Hitam(),
                                    ),

                                    child: Text(
                                      'Explore',
                                      style: TextStyle(fontSize: ukText - 6),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            ...TemplateChannel(
                              listData: _followedChannel,
                              onStatusTap: (item) {
                                setState(() {
                                  unfollowChannel(item['channel_id']);
                                });
                              },
                            ),
                          ],
                        ),

                      if ((userData?['followed_channels_by_id'] as List?)
                              ?.isEmpty ??
                          false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                "Add Status",
                                style: TextStyle(fontSize: ukText - 2),
                              ),
                              subtitle: Text(
                                'Disappears after 24 hours',
                                style: TextStyle(fontSize: ukText - 5),
                              ),

                              leading: Stack(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/person-circle.svg',
                                      fit: BoxFit.contain,
                                    ),
                                  ),

                                  Positioned(
                                    top: 30,
                                    left: 30,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: warna.Hijau(),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/plus.svg',
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              contentPadding: EdgeInsets.only(
                                left: 5,
                                right: 5,
                              ),
                            ),

                            if (_nonViewedStatus.isNotEmpty)
                              Text(
                                'New Update',
                                style: TextStyle(fontSize: ukText - 7),
                              ),

                            ...TemplateStatus(
                              listData: _nonViewedStatus,
                              onStatusTap: (item) {
                                _viewStatus(item['StatusID']);
                              },
                            ),

                            if (_viewedStatus.isNotEmpty)
                              Text(
                                'Viewed Update',
                                style: TextStyle(fontSize: ukText - 7),
                              ),

                            ...TemplateStatus(
                              listData: _viewedStatus,
                              onStatusTap: (item) {},
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Channels',
                                  style: TextStyle(fontSize: ukText),
                                ),
                                Text(
                                  'Stay updated on topic that matter to you. Find channels to follow below.',
                                  style: TextStyle(fontSize: ukText - 7),
                                ),
                              ],
                            ),
                          ],
                        ),

                      if (userData?['followed_channels_by_id'] != null)
                        Text(
                          'Find Channels to Follow',
                          style: TextStyle(fontSize: ukText - 7),
                        ),

                      ...TemplateAddChannel(
                        listData: _discoverChannel,
                        onStatusTap: (item) {
                          setState(() {
                            _followChannel(item['channel_id']);
                          });
                        },
                      ).take(4),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.pushNamed(context, "/channels");
                            _getUser();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            backgroundColor: warna.buttonPutih(),
                            foregroundColor: warna.Hitam(),
                          ),
                          child: Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/grid.svg', width: 20),
                              Text('Add Channels'),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Navigator.pushNamed(context, "/addChannel");
                            _getUser();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            backgroundColor: warna.buttonPutih(),
                            foregroundColor: warna.Hitam(),
                          ),
                          child: Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/plus.svg', width: 25),
                              Text('Add Channels'),
                            ],
                          ),
                        ),
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
    try {
      var data = await ApiServices().getData('private/channels');

      if (!mounted) {
        return;
      }

      setState(() {
        channelData = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      print("ERROR _getChannel: $e");
    }
  }

  Future<void> _getStatus() async {
    var data = await ApiServices().getData('public/users/statuses');

    if (!mounted) {
      return;
    }

    setState(() {
      statusData = List<Map<String, dynamic>>.from(data);
    });
  }

  Future<void> _getViewedStatus() async {
    var data = await ApiServices().getData('private/users/statuses');

    if (!mounted) {
      return;
    }

    setState(() {
      viewedStatusData = List<Map<String, dynamic>>.from(data);
    });

    // print("View Status $viewedStatusData");
  }

  Future<void> _getUser() async {
    String? token = await AuthService().getToken();
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
      // viewedStatusData
      viewedIds = Set<String>.from(
        viewedStatusData
            .where((index) => index['ViewerID'] == userID)
            .map((index) => index['StatusID'])
            .toSet(),
      );
    });

    _splitChannel();
    _splitStatus();
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

    globalDiscoverChannel = _discoverChannel;
    globalFollowedChannel = _followedChannel;
    setState(() {});
  }

  void _splitStatus() {
    _viewedStatus.clear();
    _nonViewedStatus.clear();

    for (var a in statusData) {
      if (viewedIds.contains(a['StatusID'])) {
        _viewedStatus.add(a);
      } else {
        _nonViewedStatus.add(a);
      }
    }

    setState(() {});
  }

  Future<void> _followChannel(String channelID) async {
    followedIds.add(channelID);
    var dataFollow = {'followed_channels_by_id': followedIds.toList()};
    await ApiServices().updateUser(dataFollow, 'private/users');

    if (!mounted) {
      return;
    }

    _splitChannel();
    _getUser();
  }

  Future<void> unfollowChannel(String channelID) async {
    followedIds.remove(channelID);

    var dataFollow = {'followed_channels_by_id': followedIds.toList()};
    await ApiServices().updateUser(dataFollow, 'private/users');

    if (!mounted) {
      return;
    }

    _splitChannel();
    _getUser();
  }

  Future<void> _viewStatus(String statusID) async {
    viewedIds.add(statusID);
    var dataViewed = {'StatusID': statusID};
    await ApiServices().postData(dataViewed, 'private/users/status/view');

    if (!mounted) {
      return;
    }

    _splitStatus();
    _getViewedStatus();
  }
}

// list
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
    onTap: () => onStatusTap(item),
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
