import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';

double ukText = 21;

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
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
                    spacing: 10,
                    children: [
                      Text('Status', style: TextStyle(fontSize: ukText)),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    20,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(3),
                                    width: 120,
                                    color: warna.Hijau(),
                                  ),
                                ),

                                Positioned(
                                  top: 13,
                                  left: 13,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: warna.Putih(),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Channels', style: TextStyle(fontSize: ukText)),
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
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

                      ...List.generate(2, (index) {
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
                            'Channel $index',
                            style: TextStyle(fontSize: ukText - 2),
                          ),
                          trailing: Text('12:13'),
                          subtitle: Text('Lorem Ipsum Dolor Amet'),
                          contentPadding: EdgeInsets.only(left: 5, right: 5),
                        );
                      }),

                      Text(
                        'Find Channels to Follow',
                        style: TextStyle(fontSize: ukText - 7),
                      ),

                      ...List.generate(4, (index) {
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
                            'Channel $index',
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
