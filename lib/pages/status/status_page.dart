import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/controllers/channel_controller.dart';
import 'package:whatsapp_clone/controllers/status_controller.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/services/route_handler.dart';
import 'package:whatsapp_clone/widgets/template_add_channel.dart';
import 'package:whatsapp_clone/widgets/template_channel.dart';
import 'package:whatsapp_clone/widgets/template_status.dart';
import 'package:whatsapp_clone/widgets/template_status_box.dart';
import 'package:whatsapp_clone/widgets/widget_pop_menu_button_three_dots_appbar.dart';

double ukText = 21;

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
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
        title: Text('Updates'),

        actions: [
          SvgPicture.asset(
            'assets/svg/search.svg',
            width: 25,
            // ignore: deprecated_member_use
            // color: warna.Hitam(),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          widgetPopMenuButtonThreeDotsAppBar(context),
        ],
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
                                        ...templateStatusBox(
                                          listData:
                                              controllerStatus.nonViewedStatus,
                                          onStatusTap: (item) {
                                            controllerStatus.viewStatus(
                                              item['StatusID'],
                                            );
                                          },
                                        ),

                                        Text('pisah'),

                                        ...templateStatusBox(
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

                                          // style: ElevatedButton.styleFrom()
                                          //     .copyWith(
                                          //       backgroundColor:
                                          //           WidgetStatePropertyAll(
                                          //             Theme.of(context)
                                          //                 .colorScheme
                                          //                 .secondaryContainer,
                                          //           ),
                                          //     ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: HSLColor.fromColor(
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                            ).withAlpha(0.3).toColor(),
                                          ),
                                          child: Text(
                                            'Explore',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.labelMedium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ...templateChannel(
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
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineLarge,
                                      ),
                                      subtitle: Text(
                                        'Disappears after 24 hours',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.displaySmall,
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
                                              'assets/svg/person-circle.svg',
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
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/svg/plus.svg',
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.surface,
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
                                  ...templateStatus(
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

                                  ...templateStatus(
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
                                ...templateAddChannel(
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
                            // shadowColor: Colors.transparent,
                            // backgroundColor: warna.buttonPutih(),
                            // foregroundColor: warna.Hitam(),
                          ),
                          child: Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/grid.svg',
                                width: 20,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
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
                            // shadowColor: Colors.transparent,
                            // backgroundColor: warna.buttonPutih(),
                            // foregroundColor: warna.Hitam(),
                          ),
                          child: Row(
                            spacing: 5,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/plus.svg',
                                width: 25,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
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
