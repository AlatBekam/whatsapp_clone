import 'dart:convert';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/Controllers/chat_controller.dart';





class Chatpage extends StatelessWidget {
  final String title;
  final String userId;

   Chatpage({super.key, required this.title, required this.userId});

   late final ChatController controller =
      Get.put(ChatController(userId: userId, title: title));
   
   final ChatController controller2 = Get.find();

    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text('C${userId}'),
                ),
                SizedBox(width: 10),
                Text(title),
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/camera.svg',
                  width: 25,
                  color: warna.Hitam(),
                ),
                SizedBox(width: 20),
                SvgPicture.asset(
                  'assets/three-dots-vertical.svg',
                  width: 25,
                  color: warna.Hitam(),
                ),
              ],
            ),
          ],
        ),
      ),
      body: GetBuilder <ChatController> (
        init: ChatController(userId: userId, title: title),
        builder: (controller) { 
          return Column(
        children: [
          // Chat messages list
          Expanded(
            child: controller2.isLoading
                ? Center(child: CircularProgressIndicator())
                : controller2.messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet.\nStart the conversation!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller2.messages.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final message = controller2.messages[index];
                      // Support multiple field names for message content
                      final messageContent =
                          message['content']?.toString() ??
                          message['message']?.toString() ??
                          message['text']?.toString() ??
                          '';
                      final isMe = controller2.checkIsMe(message);
                      final timestamp =
                          message['timestamp']?.toString() ??
                          message['created_at']?.toString() ??
                          message['time']?.toString() ??
                          '';

                      return _MessageBubble(
                        message: messageContent,
                        isMe: isMe,
                        time: timestamp,
                      );
                    },
                  ),
          ),

          // Message input
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller2.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      prefixIcon: Icon(Icons.emoji_emotions),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onSubmitted: (_) => controller2.sendMessage(),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  decoration: BoxDecoration(
                    color: warna.Hijau(),
                    shape: BoxShape.circle,
                  ),
                  child: controller2.isSending
                      ? Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : IconButton(
                          onPressed: controller2.sendMessage,
                          icon: Icon(Icons.send),
                          color: Colors.white,
                        ),
                ),
              ],
            ),
          ),
        ],
      );

      }
      ),
    );
  }
}



// Message bubble widget
class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? warna.Hijau() : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isMe ? Radius.circular(16) : Radius.circular(4),
            bottomRight: isMe ? Radius.circular(4) : Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 4),
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
      final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timeString) * 1000).toLocal();
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (e) {
      print("Error parsing time: $e");
      return '';
    }
  }
}
