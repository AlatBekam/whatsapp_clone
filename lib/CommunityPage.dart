import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'Controllers/CommunityController.dart';
import 'Services/Theme.dart';

class KomunitasPage extends StatelessWidget {

  // GETX CONTROLLER
  final CommunityController controller =
      Get.put(CommunityController());

  KomunitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warna.Putih(),
        title: Text(
          'Community',
          style: TextStyle(
            color: warna.Hitam(),
            fontSize: 19,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: warna.Putih(),
            icon: SvgPicture.asset(
              'assets/three-dots-vertical.svg',
              width: 19,
              color: warna.Hitam(),
            ),
            onSelected: (value) {
              if(value == "Pengaturan"){
                Navigator.pushNamed(
                    context,
                    '/Pengaturan'
                );
              }
            },

            itemBuilder: (context)=>[
              PopupMenuItem(
                value: "Pengaturan",
                child: Text(
                  "Pengaturan",
                  style: TextStyle(
                      color: warna.Hitam()
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Obx((){
        if(controller.isLoading.value){
          return Center(
            child: CircularProgressIndicator(),
          );
        
        }

        return ListView(
          children: [
            // CREATE COMMUNITY
            Material(
              color: warna.Putih(),
              child: InkWell(
                onTap: () async {
                  var result =
                      await Navigator.pushNamed(
                          context,
                          '/CreateCommunity'
                      );
                  if(result == true){
                    controller.fetchCommunities();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 38,
                            decoration: BoxDecoration(
                              color: warna.AbuAbu(),
                              borderRadius:
                              BorderRadius.circular(9),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/logokomunitas.svg',
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
                                borderRadius:
                                BorderRadius.circular(20),
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
                          )
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
                      )
                    ],
                  ),
                ),
              ),
            ),

            // COMMUNITY LIST
            Column(
              children: List.generate(
                controller.communities.length,
                    (index){
                  var community =
                  controller.communities[index];
                  return CommunityCard(
                      context,
                      community
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}


// COMMUNITY CARD
Widget CommunityCard(
    BuildContext context,
    dynamic community
    ){
  return Material(
    color: warna.Putih(),
    child: InkWell(
      onTap: (){
        Navigator.pushNamed(
            context,
            '/CommunityInfo',
            arguments: community
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 38,
              decoration: BoxDecoration(
                color: warna.AbuAbu(),
                borderRadius:
                BorderRadius.circular(9),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/logokomunitas.svg',
                  color: warna.Putih(),
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            SizedBox(width: 15),
            Text(
              community.communityName ??
                  community["community_name"],
              style: TextStyle(
                color: warna.Hitam(),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    ),
  );
}