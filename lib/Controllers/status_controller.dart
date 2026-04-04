import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/controllers/loading_controller.dart';
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
  final picker = ImagePicker();
  File? image;

  List<Map<String, dynamic>> funcShowViewedStatus() {
    return viewedStatus.toList();
  }

  List<Map<String, dynamic>> funcShowNonViewedStatus() {
    return nonViewedStatus.toList();
  }

  Future<void> _requestPermission({required bool isGallery}) async {
    Permission permission;
    if (isGallery) {
      permission = Permission.photos;
      permission = Permission.videos;
    } else {
      permission = Permission.camera;
    }

    if (await permission.isDenied) {
      final result = await permission.request();
      switch (result) {
        case PermissionStatus.granted:
          print('access granted');
          break;
        case PermissionStatus.denied:
          print('access denied');
          break;
        case PermissionStatus.permanentlyDenied:
          print('access permanently denied');
          break;
        default:
          print('access denied');
      }
    }
  }

  Future getStatus() async {
    // myStatusStatus.value = Status.empty;
    // status.value = Status.loading;
    String? token = await AuthService().getToken();
    var userID;

    if (token != null) {
      Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
      userID = decodeToken['id'];
    }

    var dataStatus = await ApiServices().httpGET('public/users/statuses');
    dataStatus = jsonDecode(dataStatus.body);

    final listData = List<Map<String, dynamic>>.from(dataStatus);

    await Future.wait([
      loadingController.runWithEmpty(Keys.dataFeatureStatusState, () async {
        statusDatas = List<Map<String, dynamic>>.from(
          dataStatus,
        ).where((item) => item['UserID'] != userID).toList();
      }, isEmpty: () => statusDatas.isEmpty),
      loadingController.runWithEmpty(Keys.dataFeatureMyStatusState, () async {
        myStatus.assignAll(
          List<Map<String, dynamic>>.from(
            dataStatus,
          ).where((item) => item['UserID'] == userID).toList(),
        );
      }, isEmpty: () => myStatus.isEmpty),
    ]);
  }

  Future getViewedStatus() async {
    await loadingController.run(Keys.dataFeatureStatusState, () async {
      var dataViewStatus = await ApiServices().httpGETWithToken(
        'private/users/statuses',
      );
      dataViewStatus = jsonDecode(dataViewStatus.body);

      viewedStatusDatas = List<Map<String, dynamic>>.from(dataViewStatus);
      viewedIDS = Set<String>.from(
        (dataViewStatus ?? []).map((item) => item['StatusID']),
      );
      splitStatus();
      // loadingController.stop(Keys.getViewedStatus);
    });
  }

  Future viewStatus(String StatusID) async {
    // status.value = Status.loading;

    await loadingController.run(Keys.dataFeatureStatusState, () async {
      viewedIDS.add(StatusID);
      var data = {'StatusID': StatusID};

      await ApiServices().httpPOSTWithToken(
        data: data,
        apiUrl: 'private/users/status/view',
      );

      splitStatus();
    });
  }

  void splitStatus() {
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
    }
  }

  Future<bool> addStatus(String contentStatus, [File? imgFile]) async {
    bool? result = await loadingController.run(
      Keys.dataFeatureStatusState,
      () async {
        Map<String, dynamic> statusData = {'Content': contentStatus};
        bool _isSuccess = false;

        // cek jika gambar ada
        if (imgFile != null) {
          var resImage = await ApiServices().httpPOSTWithFile(
            file: imgFile,
            apiUrl: 'private/upload',
            paths: 'statuses',
          );

          // Check jika respon null diakibatkan gagal upload (token expired)
          // check di pengiriman gambar
          if (resImage == null) {
            this.image = null;
            update();
            return false;
          }

          statusData['ImagePaths'] = resImage;
        }

        var resp = await ApiServices().httpPOSTWithToken(
          data: statusData,
          apiUrl: 'private/users/status',
        );

        // check jika respon status code 401 (token expired)
        // check di pengiriman status
        if (resp.statusCode == 401) {
          this.image = null;
          update();
        }

        // try catch untuk handle jika respon null, otomatis _isSuccess false
        try {
          var res = jsonDecode(resp.body);
          _isSuccess = res['success'];
        } catch (e) {
          print('Pengiriman status gagal : ${e}');
          _isSuccess = false;
        }

        // check jika respon success true
        if (_isSuccess == true) {
          this.image = null;
          update();
        }

        return _isSuccess;
      },
    );

    return result ?? false;
  }

  Future<bool> getImage({required bool isGallery}) async {
    // await _requestPermission(isGallery: true);

    print("masuk ke get image");
    bool? result = await loadingController.run(
      Keys.dataFeatureStatusState,
      () async {
        await _requestPermission(isGallery: isGallery);
        XFile? PickFile;

        if (isGallery) {
          PickFile = await picker.pickImage(source: ImageSource.gallery);
        } else {
          PickFile = await picker.pickImage(source: ImageSource.camera);
        }

        if (PickFile != null) {
          print("PickFile: ${PickFile.path}");
          image = File(PickFile.path);
          update();
          return true;
        }
        return false;
      },
    );
    return result ?? false;
  }

  void initData() {
    getStatus();
    getViewedStatus();
  }
}

ControllerStatus controllerStatus = Get.find<ControllerStatus>();
