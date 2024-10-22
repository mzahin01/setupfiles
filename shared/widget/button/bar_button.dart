import 'package:flutter/material.dart';
import '../../../styles/colors.dart';
import '../../../styles/spacing.dart';
import '../../../styles/text_styles.dart';

class BarButton extends StatelessWidget {
  const BarButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.buttonColor = SGColors.blue,
    this.textColor = SGColors.white,
    this.iconBorderColor,
    this.height = 48,
    this.radius = 8,
    this.icon,
    this.leftIcon,
    this.isLoadingMode = false,
    this.disabled = false,
  });

  factory BarButton.withCondition({
    required final bool condition,
    required final Function()? onPressed,
    required final String title,
  }) {
    return condition
        ? BarButton(
            title: title,
            onPressed: onPressed,
          )
        : BarButton.disabled(
            title: title,
          );
  }

  factory BarButton.primary({
    required final Function()? onPressed,
    required final String title,
    // bool disabled,
  }) {
    return BarButton(
      title: title,
      onPressed: onPressed,
    );
  }

  factory BarButton.secondary({
    required final Function()? onPressed,
    required final String title,
  }) {
    return BarButton(
      title: title,
      onPressed: onPressed,
      textColor: SGColors.blue,
      buttonColor: SGColors.veryLightBlue,
    );
  }

  factory BarButton.disabled({
    required final String title,
    final Widget? icon,
  }) {
    return BarButton(
      title: title,
      icon: icon,
      onPressed: null,
      buttonColor: SGColors.brightGray,
      textColor: SGColors.white,
    );
  }

  factory BarButton.loader() {
    return const BarButton(
      title: '',
      onPressed: null,
      buttonColor: SGColors.whiteShade3,
      textColor: SGColors.white,
      isLoadingMode: true,
    );
  }

  factory BarButton.danger({
    required final String title,
    required final Function()? onPressed,
  }) {
    return BarButton(
      title: title,
      onPressed: onPressed,
      textColor: SGColors.white,
      buttonColor: SGColors.pinkyRed,
    );
  }
  factory BarButton.secondaryDanger({
    required final String title,
    required final VoidCallback? onPressed,
  }) {
    return BarButton(
      title: title,
      onPressed: onPressed,
      textColor: SGColors.secondaryRed,
      buttonColor: SGColors.secondaryRed.withOpacity(0.1),
    );
  }

  factory BarButton.icon({
    required final String title,
    required final Function()? onPressed,
    required final Widget icon,
    final Color? buttonColor,
  }) {
    return BarButton(
      title: title,
      onPressed: onPressed,
      icon: icon,
      buttonColor: buttonColor ?? SGColors.blue,
    );
  }

  factory BarButton.leftIcon({
    required final String title,
    required final Function()? onPressed,
    required final Widget icon,
    final Color? buttonColor,
  }) {
    return BarButton(
      title: title,
      onPressed: onPressed,
      leftIcon: icon,
      buttonColor: buttonColor ?? SGColors.blue,
    );
  }
  factory BarButton.borderedIcon({
    required final String title,
    required final Function()? onPressed,
    required final Widget icon,
    required final Color iconBorderColor,
    final bool enabled = true,
  }) {
    return BarButton(
      title: title,
      onPressed: enabled ? onPressed : null,
      icon: icon,
      iconBorderColor: enabled ? iconBorderColor : SGColors.white,
    );
  }

  final VoidCallback? onPressed;
  final Color buttonColor;
  final Color textColor;
  final Color? iconBorderColor;
  final double height;
  final double radius;
  final Widget? icon;
  final Widget? leftIcon;
  final String title;
  final bool isLoadingMode;
  final bool disabled;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SGColors.whiteShade2,
        gradient: disabled
            ? null
            : const LinearGradient(
                colors: [SGColors.lightPink, SGColors.blueShade1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          minimumSize: Size.fromHeight(height),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (leftIcon != null) ...<Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: iconBorderColor ?? Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: leftIcon,
              ),
              Spacing.sb8,
            ],
            if (title.isNotEmpty)
              Text(
                title,
                style: TextStyles.pro14w600.copyWith(
                  color: SGColors.black,
                ),
              ),
            if (isLoadingMode)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(SGColors.white),
                ),
              ),
            if (icon != null) ...<Widget>[
              Spacing.sb8,
              DecoratedBox(
                decoration: BoxDecoration(
                  color: iconBorderColor ?? Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: icon,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
