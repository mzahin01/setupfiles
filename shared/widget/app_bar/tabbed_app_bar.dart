import 'package:flutter/material.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';

class TabbedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TabbedAppBar({
    super.key,
    required this.tabController,
    required this.toolbarHeight,
    required this.tabs,
    this.isScrollable = false,
    this.textStyle,
  });

  final TabController tabController;
  final double toolbarHeight;
  final List<Widget> tabs;
  final bool isScrollable;
  final TextStyle? textStyle;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: toolbarHeight,
      backgroundColor: SGColors.white,
      shadowColor: SGColors.whiteShade2,
      elevation: 1,
      title: TabBar(
        isScrollable: isScrollable,
        enableFeedback: true,
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: textStyle ?? TextStyles.subtitle1,
        indicatorColor: SGColors.blue,
        labelColor: SGColors.blue,
        unselectedLabelColor: SGColors.blackShade1,
        dividerColor: SGColors.whiteShade1,
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, toolbarHeight);
}
