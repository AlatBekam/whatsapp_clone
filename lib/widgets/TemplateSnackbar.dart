import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Services/theme/theme.dart';

class TemplateSnackbar {
  static void success(String message) {
    final context = Get.context!;
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Theme.of(context).colorScheme.primary,
      colorText: Colors.white,
    );
  }

  static void error(String message) {
    final context = Get.context!;
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Theme.of(context).colorScheme.error,
      colorText: Colors.white,
    );
  }
}