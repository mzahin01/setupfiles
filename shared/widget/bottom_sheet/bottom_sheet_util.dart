import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../styles/spacing.dart';
import 'bottom_sheet_container.dart';

class BottomSheetUtil extends GetxService {
  static BottomSheetUtil get to => Get.find();
  RoundedRectangleBorder get defaultShape => const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Spacing.xlarge),
          topRight: Radius.circular(Spacing.xlarge),
        ),
      );

  Future<void> showConfirm({
    required final String title,
    final String description = '',
    final Widget? header,
    final String buttonTitle = 'OK',
    final Widget? child,
    final bool isDismissible = true,
    final bool isDisabled = false,
    final bool isSecondary = false,
    final double? elevation,
    final RoundedRectangleBorder? shape,
    final VoidCallback? onPressed,
    final bool isScrollControlled = true,
    final bool showConfirmButton = true,
    final bool enableDrag = true,
    final EdgeInsets? padding,
    final EdgeInsets? titlePadding,
    final EdgeInsets? buttonPadding,
  }) async {
    await Get.bottomSheet(
      PopScope(
        canPop: isDismissible,
        child: BottomSheetContainer.confirm(
          header: header,
          title: title,
          padding: padding,
          description: description,
          buttonTitle: buttonTitle,
          onPressed: onPressed,
          showConfirmButton: showConfirmButton,
          isDisabled: isDisabled,
          isSecondary: isSecondary,
          titlePadding: titlePadding,
          buttonPadding: buttonPadding,
          child: child,
        ),
      ),
      shape: shape ?? defaultShape,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      elevation: elevation,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
    );
  }

  Future<void> showConfirmScrollable({
    required final String title,
    final String description = '',
    final Widget? header,
    final String buttonTitle = 'OK',
    final Widget? child,
    final bool isDismissible = true,
    final bool isDisabled = false,
    final double? elevation,
    final RoundedRectangleBorder? shape,
    final VoidCallback? onPressed,
    final bool isScrollControlled = true,
    final bool showConfirmButton = true,
    final bool enableDrag = true,
  }) async {
    await Get.bottomSheet(
      PopScope(
        canPop: isDismissible,
        child: BottomSheetContainer.scrollableConfirm(
          header: header,
          title: title,
          description: description,
          buttonTitle: buttonTitle,
          onPressed: onPressed,
          showConfirmButton: showConfirmButton,
          isDisabled: isDisabled,
          child: child,
        ),
      ),
      shape: shape ?? defaultShape,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      elevation: elevation,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
    );
  }

  void showRaw({
    required final Widget child,
    final bool isDismissible = true,
    final double? elevation,
    final RoundedRectangleBorder? shape,
  }) {
    Get.bottomSheet(
      PopScope(
        canPop: isDismissible,
        child: BottomSheetContainer(child: child),
      ),
      shape: shape ?? defaultShape,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      elevation: elevation,
    );
  }

  Future<void> showYesNo({
    required final String title,
    required final String description,
    final String positiveTitle = 'Yes',
    final String negativeTitle = 'No',
    final bool isDismissible = true,
    final double? elevation,
    final RoundedRectangleBorder? shape,
    final VoidCallback? positiveCallback,
    final VoidCallback? negativeCallback,
    final Widget? header,
    final Widget? child,
    final bool isScrollControlled = true,
    final bool isDangerAction = false,
    final bool enableDrag = true,
  }) async {
    await Get.bottomSheet(
      PopScope(
        canPop: isDismissible,
        child: BottomSheetContainer.yesNo(
          header: header,
          title: title,
          description: description,
          positiveTitle: positiveTitle,
          negativeTitle: negativeTitle,
          positiveCallback: positiveCallback,
          negativeCallback: negativeCallback,
          isDangerAction: isDangerAction,
          child: child,
        ),
      ),
      shape: shape ?? defaultShape,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      elevation: elevation,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
    );
  }

  Future<void> showYesNoScrollable({
    required final String title,
    final String description = '',
    final Widget? header,
    final String positiveTitle = 'Yes',
    final String negativeTitle = 'No',
    final bool isDismissible = true,
    final double? elevation,
    final RoundedRectangleBorder? shape,
    final VoidCallback? positiveCallback,
    final VoidCallback? negativeCallback,
    final Widget? child,
    final bool isScrollControlled = true,
    final bool enableDrag = true,
    final bool isDangerAction = false,
    final ScrollController? scrollController,
    final RxDouble? scrollableHeight,
    required final RxnInt? selectedReasonIndex,
  }) async {
    await Get.bottomSheet(
      PopScope(
        canPop: isDismissible,
        child: BottomSheetContainer.scrollableYesNo(
          scrollableHeight: scrollableHeight,
          selectedReasonIndex: selectedReasonIndex,
          header: header,
          title: title,
          scrollController: scrollController,
          description: description,
          positiveTitle: positiveTitle,
          negativeTitle: negativeTitle,
          positiveCallback: positiveCallback,
          negativeCallback: negativeCallback,
          isDangerAction: isDangerAction,
          child: child,
        ),
      ),
      shape: shape ?? defaultShape,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      elevation: elevation,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
    );
  }
}
