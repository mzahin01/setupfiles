import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../styles/spacing.dart';
import '../styles/text_styles.dart';

class ResponsiveWidget<T> extends GetResponsiveView<T> {
  ResponsiveWidget({
    super.key,
    required this.pc,
    this.tab,
    this.mobile,
    this.forceView = true,
    this.showOnlyDesktopNotice = true,
  }) : super(
         alwaysUseBuilder: false,
         settings: const ResponsiveScreenSettings(
           desktopChangePoint: 900,
           tabletChangePoint: 600,
         ),
       );

  final Widget pc;
  final Widget? tab;
  final Widget? mobile;
  final bool forceView;
  final bool showOnlyDesktopNotice;
  Widget get collapse => Visibility(
    visible: showOnlyDesktopNotice,
    child: SizedBox.expand(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svgs/prohibited.svg',
              height: 200,
              width: 200,
            ),
            Spacing.sb16,
            Text(
              'We only support desktop view currently W:${Get.width}*H:${Get.height}',
              style: TextStyles.display24w600,
              textAlign: TextAlign.center,
            ),
            Spacing.sb8,
            const Text(
              'Please expand to minimum 900px, for desktop view',
              style: TextStyles.display12,
              textAlign: TextAlign.center,
            ),
            Spacing.sb48,
          ],
        ),
      ),
    ),
  );

  @override
  Widget desktop() => pc;

  @override
  Widget tablet() => forceView ? tab ?? collapse : tab ?? pc;

  @override
  Widget phone() => forceView ? mobile ?? collapse : mobile ?? tab ?? collapse;
}
