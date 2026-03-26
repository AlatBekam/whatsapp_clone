import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/CommunityController.dart';
import 'package:whatsapp_clone/services/Theme.dart';
import 'package:whatsapp_clone/services/route_handler.dart';

class KomunitasPage extends StatelessWidget {
  final CommunityController controller = Get.find();
  // GETX CONTROLLER
  // final CommunityController controller =
  //     Get.put(CommunityController());

  KomunitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          'Community',
          style: TextStyle(color: warna.Hitam(), fontSize: 19),
        ),
        actions: [
          PopupMenuButton<String>(
            color: warna.Putih(),
            icon: SvgPicture.asset(
              'assets/svg/three-dots-vertical.svg',
              width: 19,
              color: warna.Hitam(),
            ),
            onSelected: (value) {
              if (value == "Pengaturan") {
                Get.toNamed(Routes.pengaturan);
              }
            },

            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Pengaturan",
                child: Text(
                  "Pengaturan",
                  style: TextStyle(color: warna.Hitam()),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (communityController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: [
            // CREATE COMMUNITY
            Material(
              color: warna.Putih(),
              child: InkWell(
                onTap: () async {
                  var result = await Get.toNamed(Routes.createCommunity);
                  if (result == true) {
                    communityController.fetchCommunities();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 38,
                            decoration: BoxDecoration(
                              color: warna.AbuAbu(),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/svg/logokomunitas.svg',
                                color: warna.Putih(),
                                width: 25,
                                height: 25,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -1,
                            right: -1,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: warna.Hijau(),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: warna.Putih(),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 15,
                                color: warna.Putih(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Text(
                        "New Community",
                        style: TextStyle(
                          color: warna.Hitam(),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // COMMUNITY LIST
            Column(
              children: List.generate(communityController.communities.length, (
                index,
              ) {
                var community = communityController.communities[index];
                return CommunityCard(context, community);
              }),
            ),
          ],
        );
      }),
    );
  }
}

Widget CommunityCard(
  BuildContext context,
  // dynamic community
  community,
) {
  return Column(
    children: [
      Material(
        color: warna.Putih(),
        child: InkWell(
          onTap: () {
            communityController.goDetail(community);
            // Get.toNamed(Routes.communityInfo, arguments: community);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: warna.AbuAbu(), width: 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 38,
                  decoration: BoxDecoration(
                    color: warna.AbuAbu(),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/logokomunitas.svg',
                      color: warna.Putih(),
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  community.communityName,
                  style: TextStyle(
                    color: warna.Hitam(),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: warna.Putih(),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.createCommunity);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 33,
                      decoration: BoxDecoration(
                        color: warna.Hijau(),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      margin: EdgeInsets.only(left: 2),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/speaker.svg',
                          color: warna.HijauTua(),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pengumuman',
                          style: TextStyle(
                            color: warna.Hitam(),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Name: Text',
                          style: TextStyle(
                            color: warna.AbuAbuTua(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: warna.Putih(),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.createCommunity);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 33,
                      decoration: BoxDecoration(
                        color: warna.AbuAbu(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(left: 2),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svg/logokomunitas.svg',
                          color: warna.Putih(),
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'GRUP KE-1',
                          style: TextStyle(
                            color: warna.Hitam(),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Name: Text',
                          style: TextStyle(
                            color: warna.AbuAbuTua(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: warna.Putih(),
            child: InkWell(
              onTap: () {
                Get.toNamed(Routes.createCommunity);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 33,
                      child: Center(
                        child: Icon(
                          Icons.chevron_right,
                          color: warna.AbuAbuTua(),
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      'Lihat Semua',
                      style: TextStyle(
                        color: warna.AbuAbuTua(),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
