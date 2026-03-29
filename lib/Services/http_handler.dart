import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HttpHandler {
  /// HANDLE RESPONSE (SUCCESS & ERROR)
  static dynamic handleResponse(response) {
    final statusCode = response.statusCode;

    // SUCCESS
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return true;
    }

    // ERROR
    String message = "Terjadi kesalahan";

    try {
      final body = jsonDecode(response.body);
      message = body['message'] ?? message;
    } catch (_) {}

    // HANDLE KHUSUS
    if (statusCode == 401) {
      throw Exception("Session expired, silakan login ulang");
    }

    if (statusCode == 500) {
      throw Exception("Server error");
    }

    throw Exception(message);
  }

  // /// GLOBAL SNACKBAR
  // static void showError(String message) {
  //   Get.snackbar(
  //     "Error",
  //     message,
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.red,
  //     colorText: Colors.white,
  //   );
  // }

  // static void showSuccess(String message) {
  //   Get.snackbar(
  //     "Success",
  //     message,
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.green,
  //     colorText: Colors.white,
  //   );
  // }
}