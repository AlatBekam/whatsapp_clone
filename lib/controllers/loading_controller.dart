import 'package:get/get.dart';

enum Keys {
  getMessage,
  sendMessage,
  dataFeatureChannelState,
  dataFeatureMyStatusState,
  dataFeatureStatusState,
}

enum DataState { empty, loading, error, success }

class LoadingController extends GetxController {
  var key = <Keys, DataState>{}.obs;

  DataState dataState(Keys aa) => key[aa] ?? DataState.empty;

  void start(Keys aa) {
    key[aa] = DataState.loading;
  }

  void stop(Keys aa) {
    key[aa] = DataState.success;
  }

  void error(Keys aa) {
    key[aa] = DataState.error;
  }

  void empty(Keys aa) {
    key[aa] = DataState.empty;
  }

  Future<T?> run<T>(Keys key, Future<T> Function() process) async {
    try {
      print('start loading $key');
      start(key);
      return await process();
    } on Exception catch (e) {
      print('error loading $key: $e');
      error(key);
      return null;
    } finally {
      print('stop loading $key');
      stop(key);
    }
  }

  Future<T?> runWithEmpty<T>(
    Keys key,
    Future<T> Function() process, {
    bool Function()? isEmpty,
  }) async {
    try {
      print('start loading $key');
      start(key);
      final result = await process();

      if (isEmpty != null && isEmpty()) {
        empty(key);
      } else {
        stop(key);
      }

      return result;
    } catch (e) {
      print('error loading $key: $e');
      error(key);
      return null;
    }
  }
}

LoadingController loadingController = Get.find<LoadingController>();
