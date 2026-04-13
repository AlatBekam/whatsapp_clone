import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/gambar_service.dart';
import 'package:whatsapp_clone/Services/Permission.dart';
import 'package:whatsapp_clone/controllers/loading_controller.dart';
import 'package:whatsapp_clone/preview_image.dart';

class ChatController extends GetxController {
  ApiServices _apiServices = ApiServices();
  AuthService _authService = AuthService();

  RxList<Map<String, dynamic>> messages = RxList();
  final TextEditingController messageController = TextEditingController();
  var isSending = false.obs;
  String? currentUserId;
  RxnString receiverId = RxnString();
  RxnString title = RxnString();
  String? currentChatId;
  bool _argsLoaded = false;
  final picker = ImagePicker();
  File? image;
  RequestPermission requestPermission = RequestPermission();

  @override
  void onInit() {
    super.onInit();
    _getCurrentUserId();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    await _getChatData();
    await Future.delayed(Duration(milliseconds: 100)); // Ensure ready
  }

  // Future<void> _requestPermission({required bool isGallery}) async {
  //   Permission permission = isGallery ? Permission.photos : Permission.camera;

  //   if (await permission.isDenied) {
  //     final result = await permission.request();
  //     switch (result) {
  //       case PermissionStatus.granted:
  //         print('access granted');
  //         break;
  //       case PermissionStatus.denied:
  //         print('access denied');
  //         break;
  //       case PermissionStatus.permanentlyDenied:
  //         print('access permanently denied');
  //         break;
  //       default:
  //         print('access denied');
  //     }
  //   }
  // }

  Future<void> getImage() async {
    await loadingController.runWithEmpty(Keys.getMessage, () async {
      print("masuk ke get image chat controller");
      await gambarService.getImage();

      if (GambarService.image2 != null) {
        print("PickFile: $GambarService.image2");
        image = File(GambarService.image2!.path);
        Get.to(PreviewImage(image: image!));
        update();
        // await sendMessage(); // Hapus ini agar tidak kirim otomatis
        // update();
      }
    });
  }

  // void _loadArguments() {
  //   final args = Get.arguments;
  //   if (args is Map) {
  //     receiverId.value = args['user_id']?.toString();
  //     currentChatId = args['chat_id']?.toString();
  //     print(
  //       "Args loaded: user_id=${receiverId.value}, chat_id=$currentChatId",
  //     );
  //   }
  //   _argsLoaded = true;
  //   // Data will load after user init
  //   if (currentUserId != null) _getChatData();
  // }

  Future<void> _getCurrentUserId() async {
    try {
      final token = await _authService.getToken();
      if (token != null) {
        Map<String, dynamic> decodeToken = JwtDecoder.decode(token);

        currentUserId = decodeToken['id']?.toString();
        update();
        print("Current user ID: $currentUserId");
      }
    } catch (e) {
      print("Error getting current user ID: $e");
    }
  }

  Future<void> _getChatData() async {
    if (currentUserId == null) {
      print("Current user ID not loaded yet");
      return;
    }

    await loadingController.runWithEmpty(Keys.getMessage, () async {
      final String? targetChatId = currentChatId;

      print(
        "Loading chat for user: ${receiverId.value}, chatId: $targetChatId",
      );

      // isLoading.value = true;
      await Future.delayed(Durations.medium4);
      try {
        final data = await ApiServices().httpGETWithToken("private/chats");
        // if (response.statusCode != 200) {
        //   throw Exception("Failed to load chats: ${response.statusCode}");
        // }
        // final data = jsonDecode(response.body);

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
                (id) => id.toString() == receiverId.value,
              );
            } else if (chatUsers?.toString() == receiverId.value) {
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
        // isLoading.value = false;
      }
    }, isEmpty: () => messages.isEmpty);
    // if (_currentUserId == null) {
    //   print("Current user ID not loaded yet");
    //   return;
    // }

    // final String targetUserId = user_id ?? userId;
  }

  @override
  void onReady() {
    super.onReady();
    // _loadArguments();
  }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    print("ini messageText di sendmessage: ${messageText}");
    print("ini receiverId: ${receiverId.value}");
    print("ini currentUserId: ${currentUserId}");
    if (messageText.isEmpty && image == null ||
        (receiverId.value?.isEmpty ?? true) ||
        currentUserId == null) {
      Get.snackbar("Error", "Cannot send message: Missing content or user ID");
      return;
    }

    isSending.value = true;
    update();

    try {
      String messageContent = messageText;
      String type = "text";

      // kalau ada gambar
      if (image != null) {
        final url = await _apiServices.httpPOSTWithFile(
          file: image!,
          apiUrl: "private/upload",
          paths: "chats/${currentChatId}",
        );

        if (url == null) {
          throw Exception("Upload gagal");
        }

        messageContent = url;
        type = "image";
      }

      final requestData = {
        'message': messageContent,
        'receiver_id': receiverId.value,
        'type': type,
        'sender_id': currentUserId,
        'chat_id': currentChatId ?? '',
      };
      print("Sending to receiver ${receiverId.value}: $requestData");

      final response = await ApiServices().httpPOSTWithToken(
        data: requestData,
        apiUrl: "private/chats",
      );

      messageController.clear();
      image = null;
      update();
      await _getChatData(); // Refresh
      print("Message sent successfully");
      // if (response.statusCode == 200 || response.statusCode == 201) {
      // } else {
      //   throw Exception(
      //     "Server error: ${response.statusCode} - ${response.body}",
      //   );
      // }
    } catch (e) {
      print("Send error: $e");
      Get.snackbar("Error", "Failed to send: $e");
    } finally {
      isSending.value = false;
      update();
    }
  }

  bool checkIsMe(Map<String, dynamic> message) {
    if (currentUserId == null) return false;

    // Check sender_id - can be string or int
    final senderId = message['sender_id'];
    if (senderId == null) return false;

    // Compare as strings to handle both types
    return senderId.toString() == currentUserId;
  }

  Future<dynamic>? goDetail({
    required String title,
    required String userId,
    String? chatId,
  }) async {
    receiverId.value = userId;
    currentChatId = chatId;
    chatController.title.value = title;
    await _getChatData();
    return Get.toNamed('/chat');
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  Future initData() async {
    await _getCurrentUserId();
    await _getChatData();
  }
}

ChatController chatController = Get.find<ChatController>();
