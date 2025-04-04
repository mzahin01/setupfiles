import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/spacing.dart';

class SnackbarNotification extends GetxService {
  static SnackbarNotification get to => Get.find();

  void error({required final String error, final bool forced = false}) {
    if (!forced) {
      if (Get.isBottomSheetOpen == true ||
          Get.isDialogOpen == true ||
          Get.isSnackbarOpen == true) {
        return;
      }
    } else {
      Get.closeAllSnackbars();
    }
  }

  void success({
    required final String message,
    final String title = 'Success',
  }) {
    if (Get.isSnackbarOpen) {
      Get.back();
    }

    Get.snackbar(
      title,
      message,
      backgroundColor: SGColors.secondaryGreen.withAlpha(220),
      duration: 4.seconds,
      icon: const Icon(Icons.error_outline_rounded, color: SGColors.white),
      shouldIconPulse: true,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(
        bottom: Spacing.xxxlarge2,
        left: Spacing.xlarge,
        right: Spacing.xlarge,
      ),
      padding: const EdgeInsets.all(Spacing.xlarge),
      colorText: SGColors.white,
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Ok', style: TextStyle(color: SGColors.white)),
      ),
    );
  }
}
