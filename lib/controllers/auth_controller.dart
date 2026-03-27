import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/services/api_services.dart';
import 'package:whatsapp_clone/services/route_handler.dart';

class AuthController extends GetxController {
  final ApiServices _api = ApiServices();
  final AuthService _authService = AuthService();
  final isLoading = false.obs;

  Future<void> login(String name, String password) async {
    try {
      isLoading.value = true;
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
    } catch (e) {
      Get.snackbar("Error", "Login failed, cause $e");
      print("Error at login controller $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      isLoading.value = true;
      var _data = {'name': name, 'email': email, 'password': password};
      var res = await _api.httpPOST(data: _data, apiUrl: 'public/register');
      var body = jsonDecode(res.body);

      if (body['success']) {
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      Get.snackbar("Error", "Register failed, cause $e");
      print("Error at register controller $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout(bool isLogout) async {
    try {
      isLoading.value = true;
      if (isLogout) {
        await _authService.removeToken();
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      Get.snackbar("Error", "Logout failed, cause $e");
      print("Error at logout controller $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkIfLogin() async {
    try {
      isLoading.value = true;
      String? token = await _authService.getToken();

      if (token == null) {
        Get.offAllNamed(Routes.login);
        return;
      }

      Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
      int userEXP = decodeToken['exp'];
      int timeNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      if (userEXP <= timeNow) {
        await AuthService().removeToken();

        Get.offAllNamed(Routes.login);
        return;
      }

      Get.offAllNamed(Routes.home);
    } catch (e) {
      Get.snackbar("Error", "Logout failed, cause $e");
      print("Error at checkIfLogin controller $e");
    } finally {
      isLoading.value = false;
    }
  }
}

AuthController controllerAuth = Get.find<AuthController>();
