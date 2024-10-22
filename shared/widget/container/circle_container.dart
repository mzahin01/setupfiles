import 'package:flutter/material.dart';
import '../../../styles/colors.dart';
import '../../../styles/spacing.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    this.child,
    this.color = SGColors.black,
    this.size = Spacing.medium,
    this.isBordered = false,
    this.borderWidth = 2,
  });
  final Color color;
  final double size;
  final Widget? child;
  final bool isBordered;
  final double borderWidth;

  @override
  Widget build(final BuildContext context) {
    if (!isBordered) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: child,
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        border: Border.all(color: color, width: borderWidth),
        color: SGColors.white,
      ),
    );
  }
}
