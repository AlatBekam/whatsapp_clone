import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class ControllerChannel extends GetxController {
  var followedChannel = <Map<String, dynamic>>[].obs;
  var discoverChannel = <Map<String, dynamic>>[].obs;
  Set<String> followdIDS = {};
  var userDatas = <String, dynamic>{}.obs;
  var status = Status.loading.obs;

  List<Map<String, dynamic>> channelsDatas = [];

  List<Map<String, dynamic>> funcShowFollowedChannel() {
    return followedChannel.toList();
  }

  List<Map<String, dynamic>> funcShowDiscoverChannel() {
    return discoverChannel.toList();
  }

  Future getUser() async {
    status.value = Status.loading;
    try {
      String? token = await AuthService().getToken();
      var userID;

      if (token != null) {
        Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
        userID = decodeToken['id'];
      }

      var data = await ApiServices().httpGET('public/users/$userID');
      data = jsonDecode(data.body);
      userDatas.assignAll(data);

      followdIDS = Set<String>.from(data?['followed_channels_by_id'] ?? []);

      splitchannel();
      status.value = Status.success;
    } catch (e) {
      print('Error getUser channel_controller.dart : ${e}');
      status.value = Status.error;
    }
  }

  Future getChannel() async {
    status.value = Status.loading;
    try {
      var dataChannel = await ApiServices().httpGETWithToken(
        'private/channels',
      );
      dataChannel = jsonDecode(dataChannel.body);
      channelsDatas = List<Map<String, dynamic>>.from(dataChannel);
      status.value = Status.success;
    } catch (e) {
      print('Error getChannel channel_controller.dart : ${e}');
      status.value = Status.error;
    }
  }

  Future funcFollowedChannel(String channelID) async {
    status.value = Status.loading;
    try {
      followdIDS.add(channelID);

      var dataFollow = {'followed_channels_by_id': followdIDS.toList()};

      await ApiServices().httpPUTWithToken(
        data: dataFollow,
        apiUrl: 'private/users',
      );

      getUser();
    } catch (e) {
      print('Error funcFollowedChannel channel_controller.dart : ${e}');
      status.value = Status.error;
    }
  }

  Future funcUnfollowChannel(String channelID) async {
    status.value = Status.loading;
    try {
      followdIDS.remove(channelID);

      var dataFollow = {'followed_channels_by_id': followdIDS.toList()};

      await ApiServices().httpPUTWithToken(
        data: dataFollow,
        apiUrl: 'private/users',
      );

      getUser();
    } catch (e) {
      print('Error funcUnfollowChannel channel_controller.dart : ${e}');
      status.value = Status.error;
    }
  }

  void splitchannel() {
    status.value = Status.loading;
    try {
      followedChannel.clear();
      discoverChannel.clear();

      for (var a in channelsDatas) {
        if (followdIDS.contains(a['channel_id'])) {
          followedChannel.add(a);
        } else {
          discoverChannel.add(a);
        }
      }
      status.value = Status.success;
    } catch (e) {
      print('Error splitchannel channel_controller.dart : ${e}');
      status.value = Status.error;
    }
  }

  Future<bool> addChannel(
    String nameChannel,
    String typeChannel,
    String descriptionChannel,
  ) async {
    status.value = Status.loading;
    try {
      var dataChannel = {
        'channel_name': nameChannel,
        'channel_type': typeChannel,
        'description': descriptionChannel,
      };

      var res = await ApiServices().httpPOSTWithToken(
        data: dataChannel,
        apiUrl: 'public/channels',
      );

      res = jsonDecode(res.body);
      return res['success'];
      // if (res['success']) {
      //   return true;
      // } else {
      //   return false;
      // }
    } catch (e) {
      print('Error addChannel channel_controller.dart : ${e}');
      status.value = Status.error;
      return false;
    }
  }

  Future initData() async {
    await getChannel();
    await getUser();
  }
}

ControllerChannel controllerChannel = Get.find<ControllerChannel>();
