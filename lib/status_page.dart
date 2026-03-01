import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/data_dummy.dart';

double ukText = 21;

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final List<Map<String, dynamic>> _statusData = [];
  final List<Map<String, dynamic>> _channelData = [];

  @override
  void initState() {
    super.initState();
    _statusData.addAll(StatusDummyData());
    _channelData.addAll(channelDummyData());
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

                      if (_channelData
                          .where((item) => item['isFollowing'] == true)
                          .isNotEmpty)
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...TemplateStatusBox(
                                    listData: _statusData
                                        .where((item) => item['isNew'] == true)
                                        .toList(),
                                    onStatusTap: (item) {
                                      setState(() {
                                        item['isNew'] = !item['isNew'];
                                      });
                                    },
                                  ),

                                  ...TemplateStatusBox(
                                    listData: _statusData
                                        .where((item) => item['isNew'] == false)
                                        .toList(),
                                    onStatusTap: (item) {
                                      setState(() {
                                        item['isNew'] = !item['isNew'];
                                      });
                                    },
                                  ),
                                ],
                              ),
                              // child: ListView.builder(
                              //   scrollDirection: Axis.horizontal,
                              //   itemCount: 20,
                              //   itemBuilder: (context, index) {
                              //     return Stack(
                              //       children: [
                              //         ClipRRect(
                              //           borderRadius:
                              //               BorderRadiusGeometry.circular(20),
                              //           child: Container(
                              //             margin: EdgeInsets.all(3),
                              //             width: 120,
                              //             color: warna.Hijau(),
                              //           ),
                              //         ),

                              //         Positioned(
                              //           top: 13,
                              //           left: 13,
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Container(
                              //                 width: 45,
                              //                 height: 45,
                              //                 decoration: BoxDecoration(
                              //                   color: warna.Putih(),
                              //                   shape: BoxShape.circle,
                              //                 ),
                              //               ),

                              //               Column(
                              //                 mainAxisAlignment: MainAxisAlignment.end,
                              //                 children: [
                              //                   Text(
                              //                     'Channel ${index + 1}',
                              //                     style: TextStyle(
                              //                       color: warna.Putih(),
                              //                       fontSize: ukText - 5,
                              //                     ),
                              //                   ),
                              //                   Text(
                              //                     '10${index}K Followers',
                              //                     style: TextStyle(
                              //                       color: warna.Putih(),
                              //                       fontSize: ukText - 7,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // ),
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
                                    onPressed: () {
                                      Navigator.pushNamed(context, "/channels");
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
                              listData: _channelData
                                  .where((item) => item['isFollowing'] == true)
                                  .toList(),
                            ),
                          ],
                        ),

                      if (_channelData
                          .where((item) => item['isFollowing'] == true)
                          .isEmpty)
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

                            if (_statusData
                                .where((item) => item['isNew'] == true)
                                .isNotEmpty)
                              Text(
                                'New Update',
                                style: TextStyle(fontSize: ukText - 7),
                              ),

                            ...TemplateStatus(
                              listData: _statusData
                                  .where((item) => item['isNew'] == true)
                                  .toList(),
                              onStatusTap: (item) {
                                setState(() {
                                  item['isNew'] = !item['isNew'];
                                });
                              },
                            ),

                            if (_statusData
                                .where((item) => item['isNew'] == false)
                                .isNotEmpty)
                              Text(
                                'Viewed Update',
                                style: TextStyle(fontSize: ukText - 7),
                              ),

                            ...TemplateStatus(
                              listData: _statusData
                                  .where((item) => item['isNew'] == false)
                                  .toList(),
                              onStatusTap: (item) {
                                setState(() {
                                  item['isNew'] = !item['isNew'];
                                });
                              },
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

                      if (_channelData
                          .where((item) => item['isFollowing'] == false)
                          .isNotEmpty)
                        Text(
                          'Find Channels to Follow',
                          style: TextStyle(fontSize: ukText - 7),
                        ),

                      ...TemplateAddChannel(
                        listData: _channelData
                            .where((item) => item['isFollowing'] == false)
                            .toList(),
                        onStatusTap: (item) {
                          setState(() {
                            item['isFollowing'] = !item['isFollowing'];
                          });
                        },
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/channels");
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
                          onPressed: () {
                            print('asd');
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

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Channels', style: TextStyle(fontSize: ukText)),
                      //     ClipRRect(
                      //       borderRadius: BorderRadiusGeometry.circular(10),
                      //       child: ElevatedButton(
                      //         onPressed: () {
                      //           Navigator.pushNamed(context, "/channels");
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //           elevation: 0,
                      //           shadowColor: Colors.transparent,
                      //           backgroundColor: warna.buttonPutih(),
                      //           foregroundColor: warna.Hitam(),
                      //         ),

                      //         child: Text(
                      //           'Explore',
                      //           style: TextStyle(fontSize: ukText - 6),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      // ...TemplateAddChannel(
                      //   listData: _channelData
                      //       .where((item) => item['isFollowing'] == false)
                      //       .toList(),
                      //   onStatusTap: (item) {
                      //     setState(() {
                      //       item['isFollowing'] = !item['isFollowing'];
                      //     });
                      //   },
                      // ),

                      // Text(
                      //   'Find Channels to Follow',
                      //   style: TextStyle(fontSize: ukText - 7),
                      // ),

                      // ...TemplateChat(
                      //   listData: [
                      //     {'title': 'Alice', 'subtitle': 'Hey there!'},
                      //     {'title': 'Bob', 'subtitle': 'What\'s up?'},
                      //     {
                      //       'title': 'Charlie',
                      //       'subtitle': 'Let\'s catch up soon.',
                      //     },
                      //   ],
                      // ),
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
}

// list
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
      item['title'] ?? 'Channel $index',
      style: TextStyle(fontSize: ukText - 2),
    ),
    subtitle: Text('10${index}K Followers'),
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

List<dynamic> TemplateChannel({required List<Map<String, dynamic>> listData}) =>
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
        subtitle: Text(item['subtitle'] ?? 'No subtitle'),
        contentPadding: EdgeInsets.only(left: 5, right: 5),
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
      item['title'] ?? 'Channel $index',
      style: TextStyle(fontSize: ukText - 2),
    ),
    subtitle: Text('10${index}K Followers'),
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
                  item['title'] ?? 'Title $index',
                  style: TextStyle(color: warna.Putih(), fontSize: ukText - 5),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
  // Stack(
  //       children: [
  //         ClipRRect(
  //           borderRadius:
  //               BorderRadiusGeometry.circular(20),
  //           child: Container(
  //             margin: EdgeInsets.all(3),
  //             width: 120,
  //             color: warna.Hijau(),
  //           ),
  //         ),

  //         Positioned(
  //           top: 13,
  //           left: 13,
  //           child: Column(
  //             mainAxisAlignment:
  //                 MainAxisAlignment.spaceBetween,
  //             children: [
  //               Container(
  //                 width: 45,
  //                 height: 45,
  //                 decoration: BoxDecoration(
  //                   color: warna.Putih(),
  //                   shape: BoxShape.circle,
  //                 ),
  //               ),

  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Text(
  //                     'Channel ${index + 1}',
  //                     style: TextStyle(
  //                       color: warna.Putih(),
  //                       fontSize: ukText - 5,
  //                     ),
  //                   ),
  //                   Text(
  //                     '10${index}K Followers',
  //                     style: TextStyle(
  //                       color: warna.Putih(),
  //                       fontSize: ukText - 7,
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
});

// class
                      // ...TemplateStatus(
                      //   listData: _statusData
                      //       .where((item) => item['isNew'] == true)
                      //       .toList(),
                      //   onStatusTap: (item) {
                      //     setState(() {
                      //       item['isNew'] = !item['isNew'];
                      //     });
                      //   },
                      // ),





                      // ListTile(
                      //   title: Text(
                      //     "Add Status",
                      //     style: TextStyle(fontSize: ukText - 2),
                      //   ),
                      //   subtitle: Text(
                      //     'Disappears after 24 hours',
                      //     style: TextStyle(fontSize: ukText - 5),
                      //   ),

                      //   leading: Stack(
                      //     children: [
                      //       Container(
                      //         width: 50,
                      //         height: 50,
                      //         decoration: BoxDecoration(shape: BoxShape.circle),
                      //         child: SvgPicture.asset(
                      //           'assets/person-circle.svg',
                      //           fit: BoxFit.contain,
                      //         ),
                      //       ),

                      //       Positioned(
                      //         top: 30,
                      //         left: 30,
                      //         child: Container(
                      //           width: 20,
                      //           height: 20,
                      //           decoration: BoxDecoration(
                      //             color: warna.Hijau(),
                      //             shape: BoxShape.circle,
                      //           ),
                      //           child: SvgPicture.asset('assets/plus.svg'),
                      //         ),
                      //       ),
                      //     ],
                      //   ),

                      //   contentPadding: EdgeInsets.only(left: 5, right: 5),
                      // ),

                      // Text(
                      //   'New Update',
                      //   style: TextStyle(fontSize: ukText - 7),
                      // ),

                      // ...TemplateStatus(
                      //   listData: _statusData
                      //       .where((item) => item['isNew'] == true)
                      //       .toList(),
                      //   onStatusTap: (item) {
                      //     setState(() {
                      //       item['isNew'] = !item['isNew'];
                      //     });
                      //   },
                      // ),

                      // Text(
                      //   'Viewed Update',
                      //   style: TextStyle(fontSize: ukText - 7),
                      // ),

                      // ...TemplateStatus(
                      //   listData: _statusData
                      //       .where((item) => item['isNew'] == false)
                      //       .toList(),
                      //   onStatusTap: (item) {
                      //     setState(() {
                      //       item['isNew'] = !item['isNew'];
                      //     });
                      //   },
                      // ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text('Channels', style: TextStyle(fontSize: ukText)),
                      //     Text(
                      //       'Stay updated on topic that matter to you. Find channels to follow below.',
                      //       style: TextStyle(fontSize: ukText - 7),
                      //     ),
                      //   ],
                      // ),

                      // ...TemplateChat(
                      //   listData: [
                      //     {
                      //       'title': 'Tech News',
                      //       'subtitle': 'Latest updates in tech',
                      //     },
                      //     {
                      //       'title': 'Sports',
                      //       'subtitle': 'Scores and highlights',
                      //     },
                      //     {
                      //       'title': 'Entertainment',
                      //       'subtitle': 'Celebrity news',
                      //     },
                      //   ],
                      // ),

                      // SizedBox(
                      //   width: double.infinity,
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pushNamed(context, "/channels");
                      //     },
                      //     child: Text('Explore Channels'),
                      //     style: ElevatedButton.styleFrom(
                      //       elevation: 0,
                      //       shadowColor: Colors.transparent,
                      //       backgroundColor: warna.buttonPutih(),
                      //       foregroundColor: warna.Hitam(),
                      //     ),
                      //   ),
                      // ),