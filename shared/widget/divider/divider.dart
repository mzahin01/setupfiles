import 'package:flutter/material.dart';
import '../../../styles/colors.dart';
import '../../../styles/text_styles.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Divider(
          color: SGColors.whiteShade2,
          thickness: 1,
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: SGColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: SGColors.whiteShade2, width: 1),
          ),
          child: Center(
            child: Text(
              'Or',
              style: TextStyles.pro12.copyWith(color: SGColors.blackShade1),
            ),
          ),
        ),
      ],
    );
  }
}
