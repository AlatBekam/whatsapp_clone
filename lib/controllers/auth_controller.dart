import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:whatsapp_clone/services/api_services.dart';
import 'package:whatsapp_clone/services/route_handler.dart';
import 'package:whatsapp_clone/widgets/TemplateSnackbar.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final ApiServices _api = ApiServices();
  final status = Status.success.obs;

  Future<void> login(String name, String password) async {
    status.value = Status.loading;
    try {
      final body = await _api.httpPOST(
        data: {'name': name, 'password': password},
        apiUrl: 'public/login',
      );

      print("login response: $body");

      if (body['success']) {
        await _authService.addToken(body['token']);
        Get.offAllNamed(Routes.home);
      }
      status.value = Status.success;
    } catch (e) {
      TemplateSnackbar.error("Login failed: $e");
      print("Error at login controller $e");
      status.value = Status.error;
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      status.value = Status.loading;
      var _data = {'name': name, 'email': email, 'password': password};
      final body = await _api.httpPOST(data: _data, apiUrl: 'public/users');

      if (body['success']) {
        Get.offAllNamed(Routes.login);
      }
      status.value = Status.success;
    } catch (e) {
      TemplateSnackbar.error("Register failed: $e");
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
      TemplateSnackbar.error("Logout failed: $e");
      print("Error at logout controller $e");
      status.value = Status.error;
    }
  }

  Future<void> logoutBecauseExpired(String message) async {
    try {
      await _authService.removeToken();
      AlertDialog alert = AlertDialog(
        title: Text("Your section already expired"),
        content: Text("Please login again"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.login);
            },
            child: Text("OK"),
          ),
        ],
      );

      showDialog(context: Get.context!, builder: (context) => alert);
    } catch (e) {
      TemplateSnackbar.error("Logout failed: $e");
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
      TemplateSnackbar.error("Logout failed: $e");
      print("Error at checkIfLogin controller $e");
      status.value = Status.error;
    }
  }
}

AuthController controllerAuth = Get.find<AuthController>();
