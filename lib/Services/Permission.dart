import 'package:permission_handler/permission_handler.dart';

class RequestPermission {
  Future<void> req({required bool isGallery}) async {
    Permission permission;
    if (isGallery) {
      permission = Permission.photos;
      permission = Permission.videos;
    } else {
      permission = Permission.camera;
    }

    if (await permission.isDenied) {
      final result = await permission.request();
      if (result.isGranted) {
        print('access granted');
      }
      if (result.isDenied) {
        print('access denied');
      }
      if (result.isPermanentlyDenied) {
        print('access permanently denied');
      }
    }
  }
}