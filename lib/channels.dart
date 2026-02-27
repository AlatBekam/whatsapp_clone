import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/status_page.dart';

class channels extends StatefulWidget {
  const channels({super.key});

  @override
  State<channels> createState() => _channelsState();
}

class _channelsState extends State<channels> {
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enternaiment',
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sport', style: TextStyle(fontSize: ukText - 5)),
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
