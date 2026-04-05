import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/controllers/loading_controller.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class ControllerChannel extends GetxController {
  ApiServices apiServices = ApiServices();
  AuthService _authService = AuthService();
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
    String? token = await _authService.getToken();
    var userID;

    if (token != null) {
      Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
      userID = decodeToken['id'];
    }

    var data = await apiServices.httpGET('public/users/$userID');

    await Future.wait([
      loadingController.runWithEmpty(Keys.dataFeatureChannelState, () async {
        userDatas.assignAll(data);
        followdIDS = Set<String>.from(data?['followed_channels_by_id'] ?? []);
      }, isEmpty: () => userDatas.isEmpty),
    ]);

    splitchannel();
  }

  Future getChannel() async {
    await loadingController.runWithEmpty(
      Keys.dataFeatureChannelState,
      () async {
        var dataChannel = await apiServices.httpGETWithToken(
          'private/channels',
        );

        channelsDatas = List<Map<String, dynamic>>.from(dataChannel);
      },
      isEmpty: () => discoverChannel.isEmpty,
    );
  }

  Future funcFollowedChannel(String channelID) async {
    await loadingController.run(Keys.dataFeatureChannelState, () async {
      followdIDS.add(channelID);

      var dataFollow = {'followed_channels_by_id': followdIDS.toList()};

      await apiServices.httpPUTWithToken(
        data: dataFollow,
        apiUrl: 'private/users',
      );

      getUser();
      // splitchannel();
    });
  }

  Future funcUnfollowChannel(String channelID) async {
    await loadingController.run(Keys.dataFeatureChannelState, () async {
      followdIDS.remove(channelID);

      var dataFollow = {'followed_channels_by_id': followdIDS.toList()};

      await apiServices.httpPUTWithToken(
        data: dataFollow,
        apiUrl: 'private/users',
      );

      getUser();
    });
  }

  void splitchannel() {
    followedChannel.clear();
    discoverChannel.clear();

    loadingController.runWithEmpty(Keys.dataFeatureChannelState, () async {
      for (var a in channelsDatas) {
        if (followdIDS.contains(a['channel_id'])) {
          followedChannel.add(a);
        } else {
          discoverChannel.add(a);
        }
      }
    }, isEmpty: () => discoverChannel.isEmpty);
  }

  Future<bool> addChannel(
    String nameChannel,
    String typeChannel,
    String descriptionChannel,
  ) async =>
      await loadingController.run(Keys.dataFeatureChannelState, () async {
        var dataChannel = {
          'channel_name': nameChannel,
          'channel_type': typeChannel,
          'description': descriptionChannel,
        };

        var res = await apiServices.httpPOSTWithToken(
          data: dataChannel,
          apiUrl: 'public/channels',
        );

        return res['success'];
        // if (res['success']) {
        //   return true;
        // } else {
        //   return false;
        // }
      });

  Future initData() async {
    await getChannel();
    await getUser();
  }
}

ControllerChannel controllerChannel = Get.find<ControllerChannel>();
