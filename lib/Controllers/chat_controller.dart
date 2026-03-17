import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  RxList<Map<String, dynamic>> messages = RxList();
  final TextEditingController messageController = TextEditingController();
  var isSending = false.obs;
  String? _currentUserId;
  RxnString currentUserId1 = RxnString();
  RxnString title = RxnString();
  String? currentChatId;
  bool _argsLoaded = false;
  var isLoading = false.obs;
  final picker = ImagePicker();
  File? image;



  @override
  void onInit() {
    super.onInit();
    _initializeUser();
    _getCurrentUserId();
  }

  Future<void> _initializeUser() async {
    
    await _getChatData();
    await Future.delayed(Duration(milliseconds: 100)); // Ensure ready
  }

  Future<void> _requestPermission() async {
    final permission = Permission.camera;

    if(await permission.isDenied) {
      final result =await permission.request();
      if(result.isGranted){
        print('access granted');
      }
      if(result.isDenied){
        print('access denied');
      }
      if(result.isPermanentlyDenied){
        print('access permanently denied');
      }
      }  
  }

  Future<void> getImage() async {
    await _requestPermission();
    final PickFile = await picker.pickImage(source: ImageSource.camera);
    if (PickFile != null) {
      image = PickFile as File;
      update();
      // await sendMessage();
      // update();
    }
  }

  // void _loadArguments() {
  //   final args = Get.arguments;
  //   if (args is Map) {
  //     currentUserId1.value = args['user_id']?.toString();
  //     currentChatId = args['chat_id']?.toString();
  //     print(
  //       "Args loaded: user_id=${currentUserId1.value}, chat_id=$currentChatId",
  //     );
  //   }
  //   _argsLoaded = true;
  //   // Data will load after user init
  //   if (_currentUserId != null) _getChatData();
  // }

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

  Future<void> _getChatData() async {
    if (_currentUserId == null) {
      print("Current user ID not loaded yet");
      return;
    }

    // final String targetUserId = user_id ?? userId;
    final String? targetChatId = currentChatId;

    print(
      "Loading chat for user: ${currentUserId1.value}, chatId: $targetChatId",
    );

    isLoading.value = true;
    await Future.delayed(Durations.medium4);
    try {
      final response = await ApiServices().httpGETWithToken("private/chats");
      if (response.statusCode != 200) {
        throw Exception("Failed to load chats: ${response.statusCode}");
      }
      final data = jsonDecode(response.body);

      print("Chats response: $data");

      List<Map<String, dynamic>> parsedData = [];
      if (data is Map && data['chats'] != null) {
        final chats = List<dynamic>.from(data['chats']);
        for (var chat in chats) {
          final chatUsers = chat['user_id'];
          bool matches = false;

          if (targetChatId != null &&
              chat['chat_id']?.toString() == targetChatId) {
            matches = true;
          } else if (chatUsers is List) {
            matches = chatUsers.any(
              (id) => id.toString() == currentUserId1.value,
            );
          } else if (chatUsers?.toString() == currentUserId1.value) {
            matches = true;
          }

          if (matches && chat['messages'] != null) {
            parsedData = List<Map<String, dynamic>>.from(chat['messages']);
            parsedData.sort((a, b) {
              final timeA = a['timestamp'] ?? a['created_at'] ?? '0';
              final timeB = b['timestamp'] ?? b['created_at'] ?? '0';
              return int.tryParse(
                    timeA.toString(),
                  )?.compareTo(int.tryParse(timeB.toString()) ?? 0) ??
                  0;
            });
            break;
          }
        }
      }

      messages.value = parsedData;
      print("Loaded ${messages.length} messages");
      print('$data');
      update();
    } catch (e) {
      print("GET Error: $e");

      Get.snackbar("Error", "Error loading messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    // _loadArguments();
  }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    if (messageText.isEmpty ||
        (currentUserId1.value?.isEmpty ?? true) ||
        _currentUserId == null) {
      Get.snackbar("Error", "Cannot send message: missing receiver ID");
      return;
    }

    isSending.value = true;
    update();

    try {
      final requestData = {
        'message': messageText,
        'receiver_id': currentUserId1.value,
        'sender_id': _currentUserId,
        'chat_id': currentChatId ?? '',
      };
      print("Sending to receiver ${currentUserId1.value}: $requestData");

      final response = await ApiServices().httpPOSTWithToken(
        data: requestData,
        apiUrl: "private/chats",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        messageController.clear();
        await _getChatData(); // Refresh
        print("Message sent successfully");
      } else {
        throw Exception(
          "Server error: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      print("Send error: $e");
      Get.snackbar("Error", "Failed to send: $e");
    } finally {
      isSending.value = false;
      update();
    }
  }

  bool checkIsMe(Map<String, dynamic> message) {
    if (_currentUserId == null) return false;

    // Check sender_id - can be string or int
    final senderId = message['sender_id'];
    if (senderId == null) return false;

    // Compare as strings to handle both types
    return senderId.toString() == _currentUserId;
  }

  Future<dynamic>? goDetail({
    required String title,
    required String userId,
    String? chatId,
  }) {
    currentUserId1.value = userId;
    currentChatId = chatId;
    chatController.title.value = title;
    _getChatData();
    return Get.toNamed('/chat');
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}

ChatController chatController = Get.find<ChatController>();
