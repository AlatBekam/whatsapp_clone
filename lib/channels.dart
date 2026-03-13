import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/Controllers/channel_controller.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/status_page.dart';
import 'package:whatsapp_clone/widgets/template_chat.dart';

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
    controllerChannel.initData();
  }

  @override
  Widget build(BuildContext context) {
    print('channels Load');
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

                      Obx(() {
                        return Column(
                          children: [
                            ...TemplateAddChannel(
                              listData: controllerChannel.discoverChannel
                                  .take(4)
                                  .toList(),
                              onStatusTap: (item) {
                                controllerChannel.funcFollowedChannel(
                                  item['channel_id'],
                                );
                              },
                            ),

                            if (controllerChannel.discoverChannel.any(
                              (item) => item['channel_type'] == 'Sport',
                            ))
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              listData: controllerChannel.discoverChannel
                                  .where(
                                    (tipeChannel) =>
                                        tipeChannel['channel_type'] == 'Sport',
                                  )
                                  .take(3)
                                  .toList(),
                              onStatusTap: (item) {
                                controllerChannel.funcFollowedChannel(
                                  item['channel_id'],
                                );
                              },
                            ),

                            if (controllerChannel.discoverChannel.any(
                              (item) => item['channel_type'] == 'Gaming',
                            ))
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              listData: controllerChannel.discoverChannel
                                  .where(
                                    (tipeChannel) =>
                                        tipeChannel['channel_type'] == 'Gaming',
                                  )
                                  .take(3)
                                  .toList(),
                              onStatusTap: (item) {
                                setState(() {
                                  controllerChannel.funcFollowedChannel(
                                    item['channel_id'],
                                  );
                                });
                              },
                            ),
                          ],
                        );
                      }),
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
