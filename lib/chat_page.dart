import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

List<Map<String, dynamic>> datachat = [];

class Chatpage extends StatefulWidget {
  final String title;
  final String userId;

  const Chatpage({super.key, required this.title, required this.userId});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  bool _isSending = false;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
    _getChatData();
  }

  Future<void> _getCurrentUserId() async {
    try {
      final token = await AuthService().getToken();
      if (token != null) {
        Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
        setState(() {
          _currentUserId = decodeToken['id']?.toString();
        });
        print("Current user ID: $_currentUserId");
      }
    } catch (e) {
      print("Error getting current user ID: $e");
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _getChatData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await ApiServices().httpGETWithToken("private/chats");

      // Debug: Print received data
      print("GET Response: $data");
      print("Data Type: ${data.runtimeType}");
      print("Current user ID: $_currentUserId");

      // Handle null or non-list responses
      List<Map<String, dynamic>> parsedData = [];
      if (data != null && data is Map && data['chats'] != null) {
        final chats = data['chats'] as List<dynamic>;
        for (var chat in chats) {
          if (chat['messages'] != null) {
            final messages = List<Map<String, dynamic>>.from(chat['messages']);
            parsedData.addAll(messages);
          }
        }
      }

      print("Parsed messages: $parsedData");

      setState(() {
        _messages = parsedData;
        datachat = parsedData;
      });
    } catch (e) {
      print("GET Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading messages: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    setState(() {
      _isSending = true;
    });

    try {
      // Debug: Print data yang akan dikirim
      final requestData = {
        'message': messageText,
        'receiver_id': widget.userId,
      };
      print("Sending message data: $requestData");

      // Kirim pesan ke server menggunakan endpoint /api/private/chats
      final response = await ApiServices().httpPOSTWithToken(
        data: requestData,
        apiUrl: "private/chats",
      );

      // Debug: Print response dari server
      print("POST Response Status: ${response.statusCode}");
      print("POST Response Body: ${response.body}");

      // Refresh chat data setelah mengirim pesan
      await _getChatData();

      _messageController.clear();
    } catch (e) {
      print("POST Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error sending message: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  bool _checkIsMe(Map<String, dynamic> message) {
    if (_currentUserId == null) return false;

    // Check sender_id - can be string or int
    final senderId = message['sender_id'];
    if (senderId == null) return false;

    // Compare as strings to handle both types
    return senderId.toString() == _currentUserId ||
        senderId.toString() == _currentUserId.toString();
  }

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
                  child: Text('C${widget.userId}'),
                ),
                SizedBox(width: 10),
                Text(widget.title),
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
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet.\nStart the conversation!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _messages.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      // Support multiple field names for message content
                      final messageContent =
                          message['content']?.toString() ??
                          message['message']?.toString() ??
                          message['text']?.toString() ??
                          '';
                      final isMe = _checkIsMe(message);
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
                    controller: _messageController,
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
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  decoration: BoxDecoration(
                    color: warna.Hijau(),
                    shape: BoxShape.circle,
                  ),
                  child: _isSending
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
                          onPressed: _sendMessage,
                          icon: Icon(Icons.send),
                          color: Colors.white,
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
      final DateTime dateTime = DateTime.parse(timeString);
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (e) {
      return '';
    }
  }
}
