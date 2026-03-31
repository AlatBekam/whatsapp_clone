import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/theme/theme.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;
  final String type;

  const MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? warna.Hijau() : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isMe
                ? const Radius.circular(16)
                : const Radius.circular(4),
            bottomRight: isMe
                ? const Radius.circular(4)
                : const Radius.circular(16),
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:
              // chatController.messages.map((msg) {
              //    print("FULL MSG: $msg");
              // print("MESSAGE TYPE: ${msg['type']}");
              // print("MESSAGE VALUE: ${msg['content']}");
              // final type = msg['type']?.toString().toLowerCase();
              // if (type == "image") {
              //   return Image.network(msg['content']);
              // } else {
              //   return Text(
              //     msg['content']?.toString() ?? '',
              //     style: TextStyle(
              //       color: isMe ? Colors.white : Colors.black,
              //       fontSize: 15,
              //     ),
              //   );
              // }
              // }).toList(),
              [
                if (type == "image")
                  Image.network(message)
                else
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 15,
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(time),
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black54,
                    fontSize: 11,
                  ),
                ),
              ],
        ),
      ),
    );
  }

  String _formatTime(String timeString) {
    if (timeString.isEmpty) return '';
    try {
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(timeString) * 1000,
      ).toLocal();
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (e) {
      print("Error parsing time: $e");
      return '';
    }
  }
}