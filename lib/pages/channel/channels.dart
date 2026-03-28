import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/channel_controller.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';
import 'package:whatsapp_clone/widgets/template_add_channel.dart';
import 'package:whatsapp_clone/widgets/widget_loading_transparent.dart';

class channels extends StatefulWidget {
  const channels({super.key});

  @override
  State<channels> createState() => _channelsState();
}

// print(ChannelData),
class _channelsState extends State<channels> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   controllerChannel.initData();
    // });
  }

  @override
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
                  'assets/svg/search.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                SvgPicture.asset(
                  'assets/svg/filter.svg',
                  width: 25,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
          ],
        ),
        elevation: 1,
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.black,
      ),

      body: Obx(
        () => Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore Channels',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(
                            width: 90,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                return print('Test');
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                backgroundColor: HSLColor.fromColor(
                                  Theme.of(context).colorScheme.secondary,
                                ).withAlpha(0.3).toColor(),
                              ),
                              child: Text(
                                'See All',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Obx(() {
                        // if (controllerChannel.status.value == Status.loading) {
                        //   return widgetLoadingTransparent(context);
                        // }
                        return Column(
                          children: [
                            ...templateAddChannel(
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  SizedBox(
                                    width: 90,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        return print('Test');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),
                                        backgroundColor: HSLColor.fromColor(
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ).withAlpha(0.3).toColor(),
                                      ),
                                      child: Text(
                                        'See All',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ...templateAddChannel(
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  SizedBox(
                                    width: 90,
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        return print('Test');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(0),
                                        backgroundColor: HSLColor.fromColor(
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                        ).withAlpha(0.3).toColor(),
                                      ),
                                      child: Text(
                                        'See All',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ...templateAddChannel(
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

            if (controllerChannel.status.value == Status.loading)
              widgetLoadingTransparent(context),
          ],
        ),
      ),
    );
  }
}
