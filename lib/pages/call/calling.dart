import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<CallHistory> callHistories = [
  CallHistory(
    name: "Alice",
    time: DateTime.now().subtract(Duration(minutes: 5)),
    type: CallType.incoming,
  ),
  CallHistory(
    name: "Bob",
    time: DateTime.now().subtract(Duration(hours: 1)),
    type: CallType.outgoing,
  ),
  CallHistory(
    name: "Charlie",
    time: DateTime.now().subtract(Duration(days: 1)),
    type: CallType.missed,
  ),
];

IconData getCallIcon(CallType type) {
  switch (type) {
    case CallType.incoming:
      return Icons.call_received;
    case CallType.outgoing:
      return Icons.call_made;
    case CallType.missed:
      return Icons.call_missed;
  }
}

List<IconAssets> iconAssets = [
  IconAssets(lambang: 'assets/svg/logotelepon.svg'),
  IconAssets(lambang: 'assets/svg/Dialpad.svg'),
  IconAssets(lambang: 'assets/svg/calendar.svg'),
  IconAssets(lambang: 'assets/svg/love.svg'),
];

class IconAssets {
  final String? lambang;

  IconAssets({required this.lambang});
}

enum CallType { incoming, outgoing, missed }

class CallHistory {
  final String name;
  final DateTime time;
  final CallType type;

  CallHistory({required this.name, required this.time, required this.type});
}

class Calling extends StatelessWidget {
  const Calling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/Kontak');
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add_call),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text('Panggilan'),
            Row(
              children: [
                SvgPicture.asset('assets/svg/search.svg', width: 25),
                SizedBox(width: 20),
                SvgPicture.asset(
                  'assets/svg/three-dots-vertical.svg',
                  width: 25,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: iconAssets.length,
                    itemBuilder: (context, index) {
                      var icon = iconAssets[index];
                      return Material(
                        color: Colors.grey[200],
                        shape: CircleBorder(),
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () {
                            Navigator.pushNamed(context, '/Kontak');
                          },
                          child: Container(
                            width: 90,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              child: SvgPicture.asset(
                                icon.lambang!,
                                height: 20,
                                width: 20,
                              ),
                              radius: 30,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 5),
              //   child: CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.grey[200],
              //     child: SvgPicture.asset('assets/svg/logotelepon.svg', height: 20, width: 20,),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 5),
              //   child: CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.grey[200],
              //     child: SvgPicture.asset('assets/svg/Dialpad.svg'),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 5),
              //   child: CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.grey[200],
              //     child: SvgPicture.asset('assets/svg/calendar.svg'),
              //   ),
              // ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 5),
              //   child: CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.grey[200],
              //     child: SvgPicture.asset('assets/svg/love.svg', height: 25, width: 25),
              //   ),
              // ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: callHistories.length,
              itemBuilder: (context, index) {
                var call = callHistories[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(call.name[0]),
                  ),
                  title: Text(call.name),
                  subtitle: Text(call.time.toString()),
                  trailing: Icon(getCallIcon(call.type)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
