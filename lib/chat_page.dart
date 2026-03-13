import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Controllers/chat_controller.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text('${chatController.currentUserId1.value}'),
                  ),
                  const SizedBox(width: 10),
                  Text(chatController.title.value ?? ""),
                ],
              );
            }),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/camera.svg',
                  width: 25,
                  color: warna.Hitam(),
                ),
                const SizedBox(width: 20),
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  if (chatController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (chatController.messages.isEmpty) {
                    return const Center(
                      child: Text(
                        'No messages yet.\nStart the conversation!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: chatController.messages.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final message = chatController.messages[index];
                      final messageContent =
                          message['content']?.toString() ??
                          message['message']?.toString() ??
                          message['text']?.toString() ??
                          '';
                      final isMe = chatController.checkIsMe(message);
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
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chatController.messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          prefixIcon: const Icon(Icons.emoji_emotions),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onSubmitted: (_) => chatController.sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        color: warna.Hijau(),
                        shape: BoxShape.circle,
                      ),
                      child: Obx(
                        () => chatController.isSending.value
                            ? const Padding(
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
                                onPressed: chatController.sendMessage,
                                icon: Icon(Icons.send),
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Obx(() {
          //   if (chatController.isLoading.value) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         color: Colors.black.withValues(alpha: 0.3),
          //       ),
          //       alignment: Alignment.center,
          //       child: CircularProgressIndicator(
          //         color: Theme.of(context).primaryColor,
          //       ),
          //     );
          //   }
          //   return SizedBox.shrink();
          // }),
        ],
      ),
    );
  }
}

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
          children: [
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
