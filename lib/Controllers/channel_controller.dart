import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

class ControllerChannel extends GetxController {
  var followedChannel = <Map<String, dynamic>>[].obs;
  var discoverChannel = <Map<String, dynamic>>[].obs;
  Set<String> followdIDS = {};
  var userDatas = <String, dynamic>{}.obs;
  List<Map<String, dynamic>> channelsDatas = [];

  List<Map<String, dynamic>> funcShowFollowedChannel() {
    return followedChannel.toList();
  }

  List<Map<String, dynamic>> funcShowDiscoverChannel() {
    return discoverChannel.toList();
  }

  Future getUser() async {
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
  }

  Future getChannel() async {
    try {
      var dataChannel = await ApiServices().httpGETWithToken(
        'private/channels',
      );
      dataChannel = jsonDecode(dataChannel.body);
      // print('data pada dataChannel = ${dataChannel}');

      channelsDatas = List<Map<String, dynamic>>.from(dataChannel);
      // print('ISI channelsData : ${channelsDatas}');
    } catch (e) {
      print('Error getChannel channel_controller.dart : ${e}');
    }
  }

  Future funcFollowedChannel(String channelID) async {
    followdIDS.add(channelID);

    var dataFollow = {'followed_channels_by_id': followdIDS.toList()};

    await ApiServices().httpPUTWithToken(
      data: dataFollow,
      apiUrl: 'private/users',
    );

    getUser();
  }

  Future funcUnfollowChannel(String channelID) async {
    followdIDS.remove(channelID);

    var dataFollow = {'followed_channels_by_id': followdIDS.toList()};

    await ApiServices().httpPUTWithToken(
      data: dataFollow,
      apiUrl: 'private/users',
    );

    getUser();
  }

  void splitchannel() {
    followedChannel.clear();
    discoverChannel.clear();

    for (var a in channelsDatas) {
      if (followdIDS.contains(a['channel_id'])) {
        followedChannel.add(a);
      } else {
        discoverChannel.add(a);
      }
    }
  }

  Future initData() async {
    await getChannel();
    await getUser();
  }
}
