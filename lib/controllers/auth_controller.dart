import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/services/api_services.dart';
import 'package:whatsapp_clone/services/route_handler.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final ApiServices _api = ApiServices();
  final status = Status.success.obs;

  Future<void> login(String name, String password) async {
    status.value = Status.loading;
    try {
      var res = await _api.httpPOST(
        data: {'name': name, 'password': password},
        apiUrl: 'public/login',
      );
      var body = jsonDecode(res.body);

      print(body);

      if (body['success']) {
        await _authService.addToken(body['token']);
        Get.offAllNamed(Routes.home);
      }
      status.value = Status.success;
    } catch (e) {
      Get.snackbar("Error", "Login failed, cause $e");
      print("Error at login controller $e");
      status.value = Status.error;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      status.value = Status.loading;
      var _data = {'name': name, 'email': email, 'password': password};
      var res = await _api.httpPOST(data: _data, apiUrl: 'public/users');
      var body = jsonDecode(res.body);

      if (body['success']) {
        Get.offAllNamed(Routes.login);
      }
      status.value = Status.success;
    } catch (e) {
      Get.snackbar("Error", "Register failed, cause $e");
      print("Error at register controller $e");
      status.value = Status.error;
    }
  }

  Future<void> logout(bool isLogout) async {
    status.value = Status.loading;
    try {
      if (isLogout) {
        await _authService.removeToken();
        Get.offAllNamed(Routes.login);
      }
      status.value = Status.success;
    } catch (e) {
      Get.snackbar("Error", "Logout failed, cause $e");
      print("Error at logout controller $e");
      status.value = Status.error;
    }
  }

  Future<void> checkIfLogin() async {
    status.value = Status.loading;
    try {
      String? token = await _authService.getToken();

      if (token == null) {
        status.value = Status.success;
        Get.offAllNamed(Routes.login);
        return;
      }

      Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
      int userEXP = decodeToken['exp'];
      int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      if (userEXP <= timeNow) {
        await AuthService().removeToken();
        status.value = Status.success;
        Get.offAllNamed(Routes.login);
        return;
      }

      Get.offAllNamed(Routes.home);
      status.value = Status.success;
    } catch (e) {
      Get.snackbar("Error", "Logout failed, cause $e");
      print("Error at checkIfLogin controller $e");
      status.value = Status.error;
    }
  }
}

AuthController controllerAuth = Get.find<AuthController>();
