import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';

class ControllerStatus extends GetxController {
  var viewedStatus = <Map<String, dynamic>>[].obs;
  var nonViewedStatus = <Map<String, dynamic>>[].obs;
  Set<String> viewedIDS = {};
  var userDatas = <String, dynamic>{}.obs;
  List<Map<String, dynamic>> statusDatas = [];
  List<Map<String, dynamic>> viewedStatusDatas = [];

  List<Map<String, dynamic>> funcShowViewedStatus() {
    return viewedStatus.toList();
  }

  List<Map<String, dynamic>> funcShowNonViewedStatus() {
    return nonViewedStatus.toList();
  }

  // Future getData() async {
  //   String? token = await AuthService().getToken();
  //   var userID;

  //   if (token != null) {
  //     Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
  //     userID = decodeToken['id'];
  //   }
  // }

  Future getStatus() async {
    String? token = await AuthService().getToken();
    var userID;

    if (token != null) {
      Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
      userID = decodeToken['id'];
    }

    try {
      var dataStatus = await ApiServices().httpGET('public/users/statuses');
      dataStatus = jsonDecode(dataStatus.body);

      statusDatas = List<Map<String, dynamic>>.from(
        dataStatus,
      ).where((item) => item['UserID'] != userID).toList();
    } catch (e) {
      print('Error getStatus status_controller.dart: ${e}');
    }
  }

  Future getViewedStatus() async {
    try {
      var dataViewStatus = await ApiServices().httpGETWithToken(
        'private/users/statuses',
      );
      dataViewStatus = jsonDecode(dataViewStatus.body);

      viewedStatusDatas = List<Map<String, dynamic>>.from(dataViewStatus);
      viewedIDS = Set<String>.from(
        (dataViewStatus ?? []).map((item) => item['StatusID']),
      );
      // getStatus();
      splitStatus();
    } catch (e) {
      print('Error getViewedStatus status_controller.dart: ${e}');
    }
  }

  Future viewStatus(String StatusID) async {
    try {
      viewedIDS.add(StatusID);
      var data = {'StatusID': StatusID};

      await ApiServices().httpPOSTWithToken(
        data: data,
        apiUrl: 'private/users/status/view',
      );
    } catch (e) {
      print('Error viewStatus status_controller.dart: ${e}');
    }

    splitStatus();
  }

  void splitStatus() {
    viewedStatus.clear();
    nonViewedStatus.clear();

    for (var a in statusDatas) {
      if (viewedIDS.contains(a['StatusID'])) {
        viewedStatus.add(a);
      } else {
        nonViewedStatus.add(a);
      }
    }
  }

  void initData() {
    getStatus();
    getViewedStatus();
  }
}
