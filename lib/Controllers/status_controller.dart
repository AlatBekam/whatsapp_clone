import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class ControllerStatus extends GetxController {
  var myStatus = <Map<String, dynamic>>[].obs;
  var viewedStatus = <Map<String, dynamic>>[].obs;
  var nonViewedStatus = <Map<String, dynamic>>[].obs;
  Set<String> viewedIDS = {};
  var userDatas = <String, dynamic>{}.obs;
  List<Map<String, dynamic>> statusDatas = [];
  List<Map<String, dynamic>> viewedStatusDatas = [];
  var status = Status.loading.obs;
  var myStatusStatus = Status.empty.obs;

  List<Map<String, dynamic>> funcShowViewedStatus() {
    return viewedStatus.toList();
  }

  List<Map<String, dynamic>> funcShowNonViewedStatus() {
    return nonViewedStatus.toList();
  }

  Future getStatus() async {
    myStatusStatus.value = Status.empty;
    status.value = Status.loading;
    try {
      String? token = await AuthService().getToken();
      var userID;

      if (token != null) {
        Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
        userID = decodeToken['id'];
      }

      var responseData = await ApiServices().httpGET('public/users/statuses');
      
      if (responseData.statusCode == 200) {
        var dataStatus = jsonDecode(responseData.body);
        if (dataStatus is Map && dataStatus.containsKey('data')) {
            dataStatus = dataStatus['data'];
        }

        if (dataStatus == null || dataStatus.isEmpty) {
          status.value = Status.empty;
          return;
        } else {
        statusDatas = List<Map<String, dynamic>>.from(
          dataStatus,
        ).where((item) => item['UserID'] != userID).toList();
        myStatus.assignAll(
          List<Map<String, dynamic>>.from(
            dataStatus,
          ).where((item) => item['UserID'] == userID).toList(),
        );
        print('myStatus: ${myStatus}');
        if (myStatus.isNotEmpty) {
          myStatusStatus.value = Status.success;
        }
        print('myStatusStatus: ${myStatusStatus.value}');
        }
      }
      status.value = Status.success;
    } catch (e) {
      print('Error getStatus status_controller.dart: ${e}');
      status.value = Status.error;
    }
  }

  Future getViewedStatus() async {
    status.value = Status.loading;
    try {
      var dataViewStatus = await ApiServices().httpGETWithToken(
        'private/users/statuses',
      );
      dataViewStatus = jsonDecode(dataViewStatus.body);

      viewedStatusDatas = List<Map<String, dynamic>>.from(dataViewStatus);
      viewedIDS = Set<String>.from(
        (dataViewStatus ?? []).map((item) => item['StatusID']),
      );
      splitStatus();
      status.value = Status.success;
    } catch (e) {
      print('Error getViewedStatus status_controller.dart: ${e}');
      status.value = Status.error;
    }
  }

  Future viewStatus(String StatusID) async {
    status.value = Status.loading;
    try {
      viewedIDS.add(StatusID);
      var data = {'StatusID': StatusID};

      await ApiServices().httpPOSTWithToken(
        data: data,
        apiUrl: 'private/users/status/view',
      );
      status.value = Status.success;
    } catch (e) {
      print('Error viewStatus status_controller.dart: ${e}');
      status.value = Status.error;
    }

    splitStatus();
  }

  void splitStatus() {
    status.value = Status.loading;
    try {
      viewedStatus.clear();
      nonViewedStatus.clear();

      for (var a in statusDatas) {
        if (viewedIDS.contains(a['StatusID'])) {
          viewedStatus.add(a);
        } else {
          nonViewedStatus.add(a);
        }
      }
      status.value = Status.success;
    } catch (e) {
      print('Error splitStatus status_controller.dart: ${e}');
      status.value = Status.error;
    }
  }

  Future<bool> addStatus(String contentStatus) async {
    status.value = Status.loading;
    try {
      var statusData = {'Content': contentStatus};

      var res = await ApiServices().httpPOSTWithToken(
        data: statusData,
        apiUrl: 'private/users/status',
      );

      res = jsonDecode(res.body);
      status.value = Status.success;
      return res['success'];
    } catch (e) {
      print('Error addStatus status_controller.dart: ${e}');
      status.value = Status.error;
      return false;
    }
  }

  void initData() {
    getStatus();
    getViewedStatus();
  }
}

ControllerStatus controllerStatus = Get.find<ControllerStatus>();
