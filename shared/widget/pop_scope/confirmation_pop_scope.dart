import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_sheet/bottom_sheet_util.dart';

class ConfirmationPopScope extends StatelessWidget {
  const ConfirmationPopScope({
    super.key,
    required this.child,
    this.canPop = false,
    this.onPopConfirmed,
  });
  final Widget child;
  final bool canPop;
  final VoidCallback? onPopConfirmed;

  @override
  Widget build(final BuildContext context) {
    return PopScope(
      canPop: canPop,
      // ignore: deprecated_member_use
      onPopInvoked: (final bool isPopped) {
        if (isPopped) {
          return;
        }
        BottomSheetUtil.to.showYesNo(
          title: '',
          description: '',
          isDangerAction: true,
          positiveCallback:
              onPopConfirmed ?? () => Get.until((final route) => route.isFirst),
          positiveTitle: '',
          negativeTitle: '',
        );
      },
      child: child,
    );
  }
}
