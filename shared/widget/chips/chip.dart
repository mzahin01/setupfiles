import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../styles/colors.dart';
import '../../../styles/spacing.dart';
import '../../../styles/text_styles.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.borderColor,
    required this.text,
    this.hasBackgroundColor,
    this.textStyle,
    this.asset,
  });
  final Color borderColor;
  final String? asset;
  final String text;
  final bool? hasBackgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.large,
        vertical: Spacing.small,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: (hasBackgroundColor ?? false) ? borderColor : null,
      ),
      child: Wrap(
        children: <Widget>[
          if (asset != null) ...<Widget>[SvgPicture.asset(asset!), Spacing.sb4],
          Text(
            text,
            style: textStyle ??
                TextStyles.pro10w500.copyWith(color: SGColors.blackShade1),
          ),
        ],
      ),
    );
  }
}
