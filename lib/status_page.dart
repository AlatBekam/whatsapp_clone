import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Controllers/channel_controller.dart';
import 'package:whatsapp_clone/Controllers/status_controller.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Services/route_handler.dart';
import 'package:whatsapp_clone/widgets/template_chat.dart';

double ukText = 21;

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final controllerChannel = Get.put(ControllerChannel());
  final controllerStatus = Get.put(ControllerStatus());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerChannel.initData();
    controllerStatus.initData();
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

                      Obx(() {
                        return Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((controllerChannel
                                            .userDatas['followed_channels_by_id']
                                        as List?)
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
                                          listData:
                                              controllerStatus.nonViewedStatus,
                                          onStatusTap: (item) {
                                            controllerStatus.viewStatus(
                                              item['StatusID'],
                                            );
                                          },
                                        ),

                                        Text('pisah'),

                                        ...TemplateStatusBox(
                                          listData:
                                              controllerStatus.viewedStatus,
                                          onStatusTap: (item) {
                                            ;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Channels',
                                        style: TextStyle(fontSize: ukText),
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(10),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.pushNamed(
                                              context,
                                              "/channels",
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            shadowColor: Colors.transparent,
                                            backgroundColor: warna
                                                .buttonPutih(),
                                            foregroundColor: warna.Hitam(),
                                          ),

                                          child: Text(
                                            'Explore',
                                            style: TextStyle(
                                              fontSize: ukText - 6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ...TemplateChannel(
                                    listData: controllerChannel
                                        .funcShowFollowedChannel(),
                                    onStatusTap: (item) {
                                      controllerChannel.funcUnfollowChannel(
                                        item['channel_id'],
                                      );
                                    },
                                  ),
                                ],
                              ),

                            if ((controllerChannel
                                            .userDatas['followed_channels_by_id']
                                        as List?)
                                    ?.isEmpty ??
                                false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      var result = await Get.toNamed(
                                        Routes.addStatus,
                                      );

                                      if (result == true) {
                                        controllerChannel.initData();
                                      }
                                    },
                                    child: ListTile(
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
                                  ),

                                  if (controllerStatus
                                      .nonViewedStatus
                                      .isNotEmpty)
                                    Text(
                                      'New Update',
                                      style: TextStyle(fontSize: ukText - 7),
                                    ),
                                  ...TemplateStatus(
                                    listData: controllerStatus.nonViewedStatus,
                                    onStatusTap: (item) {
                                      controllerStatus.viewStatus(
                                        item['StatusID'],
                                      );
                                    },
                                  ),

                                  if (controllerStatus.viewedStatus.isNotEmpty)
                                    Text(
                                      'Viewed Update',
                                      style: TextStyle(fontSize: ukText - 7),
                                    ),

                                  ...TemplateStatus(
                                    listData: controllerStatus.viewedStatus,
                                    onStatusTap: (item) {},
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

                            if (controllerChannel
                                    .userDatas['followed_channels_by_id'] !=
                                null)
                              Text(
                                'Find Channels to Follow',
                                style: TextStyle(fontSize: ukText - 7),
                              ),

                            Column(
                              children: [
                                ...TemplateAddChannel(
                                  listData: controllerChannel
                                      .funcShowDiscoverChannel(),
                                  onStatusTap: (item) {
                                    controllerChannel.funcFollowedChannel(
                                      item['channel_id'],
                                    );
                                  },
                                ).take(4),
                              ],
                            ),
                          ],
                        );
                      }),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.channels);
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
                            var result = await Get.toNamed(Routes.addChannel);

                            print('result muncul $result');

                            if (result == true) {
                              controllerChannel.initData();
                            }
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
}

// list
