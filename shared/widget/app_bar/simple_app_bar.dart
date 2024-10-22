import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SimpleAppBar({
    super.key,
    required this.title,
    this.systemOverlayStyle = SystemUiOverlayStyle.dark,
    this.backgroundColor = SGColors.white,
    this.centerTitle = true,
    this.textStyle,
    this.toolBarHeight = kToolbarHeight,
    this.elevation,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading,
  });

  final SystemUiOverlayStyle systemOverlayStyle;
  final Color backgroundColor;
  final String title;
  final bool centerTitle;
  final TextStyle? textStyle;
  final double toolBarHeight;
  final double? elevation;
  final List<Widget>? actions;
  final Widget? leading;
  final bool? automaticallyImplyLeading;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      systemOverlayStyle: systemOverlayStyle,
      backgroundColor: backgroundColor,
      shadowColor: SGColors.whiteShade2,
      centerTitle: centerTitle,
      iconTheme: const IconThemeData(color: SGColors.black),
      title: Text(
        title,
        style:
            textStyle ?? TextStyles.pro16w600.copyWith(color: SGColors.black),
      ),
      elevation: elevation ?? 1,
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, toolBarHeight);
}
