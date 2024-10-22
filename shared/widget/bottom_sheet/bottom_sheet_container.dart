import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/colors.dart';
import '../../../styles/spacing.dart';
import '../../../styles/text_styles.dart';
import '../button/bar_button.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    super.key,
    required this.child,
    this.height,
    this.color = SGColors.white,
    this.visibleHandle = false,
  });

  factory BottomSheetContainer.confirm({
    required final String title,
    required final String buttonTitle,
    final String description = '',
    final bool showConfirmButton = true,
    final bool isDisabled = false,
    final bool isSecondary = false,
    final Widget? child,
    final VoidCallback? onPressed,
    final Widget? header,
    final EdgeInsetsGeometry? padding,
    final EdgeInsetsGeometry? titlePadding,
    final EdgeInsetsGeometry? buttonPadding,
  }) {
    return BottomSheetContainer(
      child: Padding(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: Spacing.xlarge2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (header != null) ...<Widget>[
              header,
              Spacing.sb24,
            ],
            if (title.isNotEmpty) ...<Widget>[
              Padding(
                padding: titlePadding ?? EdgeInsets.zero,
                child: Text(
                  title,
                  style:
                      TextStyles.display20w600.copyWith(color: SGColors.black),
                ),
              ),
              Spacing.sb8,
            ],
            if (description.isNotEmpty) ...<Widget>[
              Text(
                description,
                style: TextStyles.pro14.copyWith(color: SGColors.blackShade1),
              ),
              Spacing.sb20,
            ],
            if (child != null) ...<Widget>[
              child,
              Spacing.sb16,
            ],
            if (showConfirmButton)
              Padding(
                padding: buttonPadding ?? EdgeInsets.zero,
                child: isDisabled
                    ? BarButton.disabled(title: buttonTitle)
                    : isSecondary
                        ? BarButton.secondary(
                            onPressed: onPressed ?? Get.back,
                            title: buttonTitle,
                          )
                        : BarButton.primary(
                            onPressed: onPressed ?? Get.back,
                            title: buttonTitle,
                          ),
              ),
          ],
        ),
      ),
    );
  }

  factory BottomSheetContainer.scrollableConfirm({
    required final String title,
    final String description = '',
    required final String buttonTitle,
    final bool showConfirmButton = true,
    final bool isDisabled = false,
    final Widget? child,
    final VoidCallback? onPressed,
    final Widget? header,
  }) {
    return BottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Spacing.xlarge2,
          right: Spacing.xlarge2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (header != null) ...<Widget>[
              header,
              Spacing.sb24,
            ],
            if (title.isNotEmpty) ...<Widget>[
              Text(
                title,
                style: TextStyles.display20w600.copyWith(color: SGColors.black),
              ),
              Spacing.sb8,
            ],
            if (description.isNotEmpty) ...<Widget>[
              Text(
                description,
                style: TextStyles.pro14.copyWith(color: SGColors.blackShade1),
              ),
              Spacing.sb20,
            ],
            if (child != null) ...<Widget>[
              Scrollbar(
                thumbVisibility: true,
                child: SizedBox(
                  height: 400, //height - 180 + (title.isEmpty ? 40 : 0),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: Spacing.medium),
                        child: child,
                      ),
                    ],
                  ),
                ),
              ),
              // child,
              Spacing.sb16,
            ],
            if (showConfirmButton)
              isDisabled
                  ? BarButton.disabled(title: buttonTitle)
                  : BarButton.primary(
                      onPressed: onPressed ?? Get.back,
                      title: buttonTitle,
                    ),
          ],
        ),
      ),
    );
  }

  factory BottomSheetContainer.scrollableYesNo({
    required final String title,
    final String description = '',
    final bool isDangerAction = false,
    final String positiveTitle = 'Yes',
    final String negativeTitle = 'No',
    final VoidCallback? positiveCallback,
    final VoidCallback? negativeCallback,
    final ScrollController? scrollController,
    final Widget? child,
    final Widget? header,
    final RxDouble? scrollableHeight,
    required final RxnInt? selectedReasonIndex,
  }) {
    return BottomSheetContainer(
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.only(
            left: Spacing.xlarge2,
            right: Spacing.xlarge2,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (header != null) ...<Widget>[
                header,
                Spacing.sb24,
              ],
              if (title.isNotEmpty) ...<Widget>[
                Text(
                  title,
                  style:
                      TextStyles.display20w600.copyWith(color: SGColors.black),
                ),
                Spacing.sb8,
              ],
              if (description.isNotEmpty) ...<Widget>[
                Text(
                  description,
                  style: TextStyles.pro14.copyWith(color: SGColors.blackShade1),
                ),
                Spacing.sb20,
              ],
              if (child != null) ...<Widget>[
                Scrollbar(
                  thumbVisibility: true,
                  child: SizedBox(
                    height: scrollableHeight != null
                        ? scrollableHeight.value
                        : title.isEmpty
                            ? 500
                            : 400,
                    child: ListView(
                      controller: scrollController,
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: Spacing.medium),
                          child: child,
                        ),
                      ],
                    ),
                  ),
                ),
                // child,
                Spacing.sb16,
              ],
              Row(
                children: <Widget>[
                  Expanded(
                    child: BarButton.secondary(
                      onPressed: negativeCallback ?? Get.back,
                      title: negativeTitle,
                    ),
                  ),
                  Spacing.sb16,
                  Expanded(
                    child: selectedReasonIndex?.value == null
                        ? BarButton.disabled(title: positiveTitle)
                        : isDangerAction
                            ? BarButton.danger(
                                onPressed: positiveCallback ?? Get.back,
                                title: positiveTitle,
                              )
                            : BarButton.primary(
                                onPressed: positiveCallback ?? Get.back,
                                title: positiveTitle,
                              ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  factory BottomSheetContainer.yesNo({
    required final String title,
    required final String description,
    final bool isDangerAction = false,
    final String positiveTitle = 'Yes',
    final String negativeTitle = 'No',
    final VoidCallback? positiveCallback,
    final VoidCallback? negativeCallback,
    final Widget? header,
    final Widget? child,
  }) {
    return BottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xlarge2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (header != null) ...<Widget>[
              header,
              Spacing.sb24,
            ],
            if (title.isNotEmpty) ...<Widget>[
              Text(
                title,
                style: TextStyles.display20w600.copyWith(color: SGColors.black),
              ),
              Spacing.sb8,
            ],
            if (description.isNotEmpty) ...<Widget>[
              Text(
                description,
                style: TextStyles.pro14.copyWith(color: SGColors.blackShade1),
              ),
              Spacing.sb20,
            ],
            if (child != null) ...<Widget>[
              child,
              Spacing.sb16,
            ],
            Row(
              children: <Widget>[
                Expanded(
                  child: BarButton.secondary(
                    onPressed: negativeCallback ?? Get.back,
                    title: negativeTitle,
                  ),
                ),
                Spacing.sb16,
                Expanded(
                  child: isDangerAction
                      ? BarButton.danger(
                          onPressed: positiveCallback ?? Get.back,
                          title: positiveTitle,
                        )
                      : BarButton.primary(
                          onPressed: positiveCallback ?? Get.back,
                          title: positiveTitle,
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget child;
  final double? height;
  final Color? color;
  final bool visibleHandle;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: color,
      ),
      padding: EdgeInsets.only(
        top: Spacing.xxxlarge,
        bottom: MediaQuery.of(context).padding.bottom + Spacing.large,
      ),
      child: Wrap(
        children: <Widget>[
          if (visibleHandle) ...<Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 72,
                height: 5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  color: SGColors.coolGrey,
                ),
              ),
            ),
            Spacing.sb24,
          ],
          child,
        ],
      ),
    );
  }
}
