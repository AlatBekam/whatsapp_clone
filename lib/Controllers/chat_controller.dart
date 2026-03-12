import 'dart:convert';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart'; 
import 'package:flutter/material.dart';


class ChatController extends GetxController {
    String title;
    String userId;

  ChatController({required this.title, required this.userId});

  
  List<Map<String, dynamic>> datachat = [];
  List<Map<String, dynamic>> messages = [];
  final TextEditingController messageController = TextEditingController();
  bool isSending = false;
  String? _currentUserId;
  String? user_id;
  String? currentChatId;
  bool _argsLoaded = false;
  bool isLoading = false;

   @override
  void onInit() {
    super.onInit();
    print("UserId: $userId");
    print("ChatId: $title");
    _getCurrentUserId();
  }


  Future<void> _getChatData() async {
    // Use widget.userId as fallback if user_id is null
    final String? targetUserId = user_id ?? userId;
    final String? targetChatId = currentChatId;
    
    print("Getting chat data for userId: $targetUserId, chatId: $targetChatId");
    
    if (targetUserId == null) {
      print("Waiting for user ID to load...");
      return;
    }

      isLoading = true;
      update();

    try {
      final datauser = await ApiServices().httpGETWithToken("private/chats");
      final data = jsonDecode(datauser.body);


      // Debug: Print received data
      print("GET Response: $data");
      print("Data Type: ${data.runtimeType}");
      print("Filtering for user_id: $targetUserId and currentChatId: $targetChatId");
      
      // Handle null or non-list responses
      List<Map<String, dynamic>> parsedData = [];
      if (data != null && data is Map && data['chats'] != null) {
        final chats = data['chats'] as List<dynamic>;
        for (var chat in chats) {
          print("Checking chat: chat_id=${chat['chat_id']}, user_id=${chat['user_id']}");
          
          // Try matching with chat_id if available, otherwise just match user_id
          bool matches = false;
          if (targetChatId != null) {
            matches = chat['chat_id'].toString() == targetChatId;
          } else {
            // user_id is an array [1, 2], check if targetUserId is in the array
            final chatUserIds = chat['user_id'];
            if (chatUserIds is List) {
              matches = chatUserIds.any((id) => id.toString() == targetUserId);
            } else {
              // If single value
              matches = chatUserIds.toString() == targetUserId;
            }
          }
          
          if (matches) {
            if (chat['messages'] != null) {
              final messages = List<Map<String, dynamic>>.from(chat['messages']);
              parsedData.addAll(messages);
            }
            break;
          }
        }
      }

      print("Parsed messages: $parsedData");

      
        messages = parsedData;
        datachat = parsedData;
      update();
    } catch (e) {
      print("GET Error: $e");
      
        Get.snackbar(
        "Error",
        "Error loading messages: $e",);
      
    } finally {    
          isLoading = false;
        update();
    }
  }

  Future<void> _getCurrentUserId() async {
    try {
      final token = await AuthService().getToken();
      if (token != null) {
        Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
        
          _currentUserId = decodeToken['id']?.toString();
        update();
        print("Current user ID: $_currentUserId");
      }
    } catch (e) {
      print("Error getting current user ID: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (!_argsLoaded) {
      final args = Get.arguments;

      if (args is Map) {
        user_id = args['user_id']?.toString();
        currentChatId = args['chat_id']?.toString();
        print("Loaded user_id: $user_id");
        print("Loaded chat_id: $currentChatId");
      }

      _argsLoaded = true;
      _getChatData();
    }
  }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    
      isSending = true;
    update();


    try {
      // Debug: Print data yang akan dikirim
      final requestData = {
        'message': messageText,
        'receiver_id': userId,
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

      messageController.clear();
    } catch (e) {
      print("POST Error: $e");
        Get.snackbar('Error', 'Error sending message: $e');
    } finally {
      isSending = false;
    update();
    }
  }

   bool checkIsMe(Map<String, dynamic> message) {
    if (_currentUserId == null) return false;

    // Check sender_id - can be string or int
    final senderId = message['sender_id'];
    if (senderId == null) return false;

    // Compare as strings to handle both types
    return senderId.toString() == _currentUserId ||
        senderId.toString() == _currentUserId.toString();
  }
}