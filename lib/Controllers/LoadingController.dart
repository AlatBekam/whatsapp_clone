import 'package:get/get.dart';

enum LoadingKey { getMessage, sendMessage }

class LoadingController extends GetxController {
  var loadingMap = <String, bool>{}.obs;

  bool isLoading(String key) => loadingMap[key] ?? false;

  void start(String key) {
    loadingMap[key] = true;
  }

  void stop(String key) {
    loadingMap[key] = false;
  }

  Future<T?> run<T>(String key, Future<T> Function() process) async {
    try {
      print('start loading $key');
      start(key);
      return await process();
    } finally {
      print('stop loading $key');
      stop(key);
    }
  }
}

LoadingController loadingController = Get.find<LoadingController>();
