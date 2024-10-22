import 'package:flutter/material.dart';
import '../../../styles/colors.dart';
import '../loader/loader.dart';

class CrossfadeWrapperContainer extends StatelessWidget {
  const CrossfadeWrapperContainer({
    required this.visible,
    required this.child,
    this.replacement,
    this.useLoader = true,
    this.loaderHeight,
    this.alignment = Alignment.center,
    this.duration = const Duration(milliseconds: 300),
    super.key,
  });

  final Widget child;
  final Widget? replacement;
  final Duration duration;
  final bool visible;
  final Alignment alignment;
  final bool useLoader;
  final double? loaderHeight;
  Widget get loader => loaderHeight == null
      ? Loader.circle()
      : Container(
          height: loaderHeight,
          width: double.maxFinite,
          color: SGColors.white,
          child: Center(child: Loader.circle()),
        );
  Widget get empty => const SizedBox.shrink();

  @override
  Widget build(final BuildContext context) {
    return AnimatedCrossFade(
      firstChild: child,
      secondChild: empty,
      crossFadeState:
          visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
      alignment: alignment,
      layoutBuilder:
          (final Widget first, final _, final Widget second, final __) =>
              visible ? first : replacement ?? (useLoader ? loader : empty),
    );
  }
}
