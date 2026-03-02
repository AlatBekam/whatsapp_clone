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
          // Handle new call action
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add_call),
      ),
      appBar: AppBar(
        title: 
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
          children: [
            Text('Panggilan'),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/search.svg',
                  width: 25,
                        ),
                SizedBox(width: 20),
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset('assets/logotelepon.svg', height: 20, width: 20,),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset('assets/Dialpad.svg'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset('assets/calendar.svg'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset('assets/love.svg', height: 25, width: 25),
                ),
              ),
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
            }
            ),
        )
        ],
      )
    );
  }
}