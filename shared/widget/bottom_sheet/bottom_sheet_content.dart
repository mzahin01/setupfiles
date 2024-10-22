import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../styles/colors.dart';
import '../../../styles/spacing.dart';
import '../../../styles/text_styles.dart';
import '../button/bar_button.dart';
import '../text_field/general_text_field.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({super.key, required this.child});

  factory BottomSheetContent.radio({
    final RxInt? selectedIndex,
    final List<String>? options,
    final bool? line,
    final Color? selectedColor,
  }) {
    return BottomSheetContent(
      child: StatefulBuilder(
        builder: (final _, final Function modalState) {
          return Padding(
            padding: EdgeInsets.only(top: (line ?? false) ? 18.0 : 0),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (final _, final int index) => GestureDetector(
                onTap: () {
                  modalState(() {
                    selectedIndex?.value = index;
                  });
                },
                child: Column(
                  children: <Widget>[
                    if (line ?? false) ...<Widget>{
                      const Divider(
                        color: SGColors.whiteShade1,
                        height: 2,
                        thickness: 2,
                      ),
                      Spacing.sb16,
                    },
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.xlarge2,
                      ),
                      child: Row(
                        children: <Widget>[
                          // if ((line ?? false) == false) ...[
                          //   SvgPicture.asset(
                          //     selectedIndex?.value == index
                          //         ? SVGAsset.check_on_ic
                          //         : SVGAsset.check_off_ic,
                          //     height: 32,
                          //     width: 32,
                          //   ),
                          //   const SizedBox(width: Spacing.large),
                          // ],
                          Expanded(
                            child: Text(
                              options?.elementAt(index) ?? '',
                              style: TextStyles.pro16w400.copyWith(
                                color: selectedIndex?.value == index
                                    ? selectedColor
                                    : SGColors.blackShade1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (line ?? false) ...<Widget>{
                      Spacing.sb8,
                    },
                  ],
                ),
              ),
              separatorBuilder: (final _, final __) => Spacing.sb8,
              itemCount: options?.length ?? 0,
            ),
          );
        },
      ),
    );
  }

  factory BottomSheetContent.durationSpinner({
    required final RxInt time,
    final int minuteInterval = 15,
    final Duration? maxDuration,
    final int minimunDurationInSeconds = 0,
  }) {
    final Duration minDuration = Duration(seconds: minimunDurationInSeconds);
    final int extraSeconds = (time.value % (minuteInterval * 60)) == 0
        ? 0
        : (minuteInterval * 60) - (time.value % (minuteInterval * 60));
    Duration duration =
        Duration(seconds: time.value).inMinutes < minDuration.inMinutes
            ? minDuration
            : Duration(seconds: time.value + extraSeconds);
    // Duration(seconds: time.value).inMinutes % minuteInterval != 0
    //     ? minDuration
    //     : Duration(seconds: time.value);
    time.value = duration.inSeconds;
    return BottomSheetContent(
      child: StatefulBuilder(
        builder: (final _, final Function spinnerState) {
          return SizedBox(
            height: 200,
            child: CupertinoTimerPicker(
              key: UniqueKey(),
              mode: CupertinoTimerPickerMode.hm,
              minuteInterval: minuteInterval,
              initialTimerDuration: duration,
              onTimerDurationChanged: (final Duration changedtimer) {
                if (changedtimer.inSeconds < minimunDurationInSeconds) {
                  spinnerState(() {
                    duration = minDuration;
                  });
                } else if (maxDuration != null &&
                    changedtimer.inMinutes > (maxDuration.inMinutes)) {
                  spinnerState(() {
                    duration = maxDuration;
                  });
                } else {
                  duration = changedtimer;
                }
                time.value = duration.inSeconds;
              },
            ),
          );
        },
      ),
    );
  }

  factory BottomSheetContent.dateSpinner({
    required final Rx<DateTime?> date,
    final DateTime? minDate,
    final DateTime? maxDate,
    final VoidCallback? onChanged,
  }) {
    return BottomSheetContent(
      child: StatefulBuilder(
        builder: (final _, final Function spinnerState) {
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              key: UniqueKey(),
              initialDateTime: DateUtils.dateOnly(date.value ?? DateTime.now()),
              mode: CupertinoDatePickerMode.date,
              minimumDate: DateUtils.dateOnly(minDate ?? DateTime.now()),
              maximumDate: DateUtils.dateOnly(maxDate ?? DateTime.now()),
              onDateTimeChanged: (final DateTime value) {
                date.value = DateUtils.dateOnly(value);
                if (onChanged != null) {
                  onChanged();
                }
              },
            ),
          );
        },
      ),
    );
  }
  factory BottomSheetContent.withTextInput({
    required final String label,
    required final TextEditingController textEditingController,
    final String confirmButtonTitle = 'Confirm',
    final String cancelButtonTitle = 'Cancel',
    final bool showCancelButton = false,
    final Widget? prefixIcon,
    final VoidCallback? onSubmit,
    final VoidCallback? onCancel,
    final Function? validation,
    final Widget? suffixIcon,
    // :NOTE: When modal needs to be updated with the call, else use IconButton for suffixIcon
    final VoidCallback? onSuffixIconPressed,
  }) {
    return BottomSheetContent(
      child: StatefulBuilder(
        builder: (final _, final Function modalState) {
          return ListView.custom(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            childrenDelegate: SliverChildListDelegate.fixed(
              <Widget>[
                TextFieldWidget.oneLine(
                  keyboardType: TextInputType.emailAddress,
                  padding: EdgeInsets.zero,
                  suffixIcon: suffixIcon,
                  onSuffixIconPressed: () => modalState(() {
                    onSuffixIconPressed?.call();
                  }),
                  labelText: label,
                  controller: textEditingController,
                  onChanged: (final String value) => modalState(() {}),
                  prefixIcon: prefixIcon,
                ),
                Spacing.sb28,
                Row(
                  children: <Widget>[
                    if (showCancelButton) ...<Widget>[
                      Expanded(
                        child: BarButton.secondary(
                          onPressed: onCancel ?? () => Get.back(),
                          title: cancelButtonTitle,
                        ),
                      ),
                      Spacing.sb8,
                    ],
                    Expanded(
                      child: Visibility(
                        visible: validation?.call() ?? true,
                        replacement:
                            BarButton.disabled(title: confirmButtonTitle),
                        child: BarButton.primary(
                          onPressed: onSubmit,
                          title: confirmButtonTitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  factory BottomSheetContent.intSingleNumberSpinner({
    required final RxnInt number,
    required final String unit,
    final int? minNumber,
    final int? maxNumber,
    final Function(int)? onChanged,
  }) {
    number.value ??= minNumber;
    return BottomSheetContent(
      child: StatefulBuilder(
        builder: (final _, final Function spinnerState) {
          return SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: number.value != null
                          ? number.value! - (minNumber ?? 0)
                          : 0,
                    ),
                    onSelectedItemChanged: (final int x) {
                      number.value = x + (minNumber ?? 0);
                      onChanged?.call(x + (minNumber ?? 0));
                    },
                    itemExtent: 30,
                    children: List<Widget>.generate(
                      (maxNumber ?? 100) - (minNumber ?? 0),
                      (final int index) => Text(
                        '${index + (minNumber ?? 0)}',
                        style: TextStyles.pro23w600
                            .copyWith(color: SGColors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: 0),
                    onSelectedItemChanged: (final int x) {},
                    itemExtent: 30,
                    children: <Widget>[
                      Text(
                        unit,
                        style: TextStyles.pro23w600
                            .copyWith(color: SGColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  factory BottomSheetContent.doubleSingleNumberSpinner({
    required final RxnDouble number,
    required final String unit,
    final double? minNumber,
    final double? maxNumber,
  }) {
    number.value ??= minNumber;
    return BottomSheetContent(
      child: StatefulBuilder(
        builder: (final _, final Function spinnerState) {
          return SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: (number.value != null &&
                              number.value! < (maxNumber ?? 0) &&
                              number.value! >= (minNumber ?? 0))
                          ? (number.value!.floor() - (minNumber ?? 0).toInt())
                          : 0,
                    ),
                    onSelectedItemChanged: (final int x) {
                      number.value ??= 20;
                      number.value = (x + (minNumber ?? 0)).toDouble() +
                          (number.value! - number.value!.floor());
                      number.value =
                          double.parse(number.value!.toStringAsFixed(1));
                    },
                    itemExtent: 30,
                    children: <Widget>[
                      for (int i = minNumber?.toInt() ?? 0;
                          i < (maxNumber ?? 0);
                          i += 1)
                        Text(
                          '$i',
                          style: TextStyles.pro23w600
                              .copyWith(color: SGColors.black),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: (number.value != null &&
                              number.value! < (maxNumber ?? 0) &&
                              number.value! >= (minNumber ?? 0))
                          ? ((number.value! - number.value!.floor()) * 10)
                              .round()
                          : 0,
                    ),
                    onSelectedItemChanged: (final int x) {
                      number.value = number.value!.floor() + (x / 10);
                    },
                    itemExtent: 30,
                    children: List<Widget>.generate(
                      10,
                      (final int index) => Text(
                        '.$index',
                        style: TextStyles.pro23w600
                            .copyWith(color: SGColors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: 0),
                    onSelectedItemChanged: (final int x) {},
                    itemExtent: 30,
                    children: <Widget>[
                      Text(
                        unit,
                        style: TextStyles.pro23w600
                            .copyWith(color: SGColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final Widget child;
  @override
  Widget build(final BuildContext context) {
    return Center(
      child: child,
    );
  }
}
