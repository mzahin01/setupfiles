import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../../styles/colors.dart';
import '../container/circle_container.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key, required this.child});

  factory BottomSheetHeader.delete() {
    return BottomSheetHeader.withIcon(
      icon: Icons.delete_outline_rounded,
    );
  }

  factory BottomSheetHeader.withIcon({
    required final IconData icon,
    final double iconSize = 32,
  }) {
    return BottomSheetHeader(
      child: CircleContainer(
        size: 64,
        color: SGColors.secondaryRed.withOpacity(0.1),
        child: Icon(
          icon,
          size: iconSize,
          color: SGColors.secondaryRed,
        ),
      ),
    );
  }
  factory BottomSheetHeader.withSvg({
    required final String svgAsset,
    final double size = 32,
  }) {
    return BottomSheetHeader(
      child: SvgPicture.asset(
        svgAsset,
        width: size,
        height: size,
      ),
    );
  }

  factory BottomSheetHeader.withLottie({
    final AnimationController? lottieController,
    required final String lottieAsset,
    final bool repeat = true,
    final double height = 200,
    final double width = 200,
  }) {
    return BottomSheetHeader(
      child: SizedBox(
        height: height,
        width: width,
        child: Lottie.asset(
          lottieAsset,
          controller: lottieController,
          repeat: repeat,
        ),
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
