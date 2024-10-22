import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../styles/colors.dart';
import '../../../styles/spacing.dart';
import '../../../styles/text_styles.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.title,
    this.titleTextStyle,
    required this.controller,
    this.hintText,
    this.maxLength,
    this.errorText,
    this.borderRadious = 8,
    this.ontap,
    this.lineCount,
    this.scrollPadding,
    this.contentPadding,
    this.prefixPadding,
    this.suffixIcon,
    this.readOnly = false,
    this.enable = true,
    this.showCursor = true,
    this.textAlignVertical = TextAlignVertical.center,
    this.labelText,
    this.labelStyle = const TextStyle(color: SGColors.black, fontSize: 14),
    this.prefixIcon,
    this.onChanged,
    this.padding,
    this.inputFormatter,
    this.keyboardType,
    this.focusNode,
    this.height,
    required this.multiline,
    this.onSuffixIconPressed,
    this.obsecureText = false,
    this.backgroundColor,
    this.borderColor,
    this.hintStyle = const TextStyle(color: SGColors.deepBlue),
  });

  factory TextFieldWidget.oneLine({
    required final TextEditingController controller,
    final String? title,
    final String? errorText,
    final String? hintText,
    final int? maxLength,
    final VoidCallback? ontap,
    final Widget? suffixIcon,
    final bool readOnly = false,
    final bool showCursor = true,
    final bool enable = true,
    final String? labelText,
    final TextStyle? labelStyle,
    final TextAlignVertical? textAlignVertical,
    final Widget? prefixIcon,
    final EdgeInsets? padding,
    final TextInputFormatter? inputFormatter,
    final TextInputType? keyboardType,
    final FocusNode? focusNode,
    final double? height,
    final EdgeInsets? scrollPadding,
    final EdgeInsets? prefixPadding,
    final Function(String value)? onChanged,
    final VoidCallback? onSuffixIconPressed,
    final bool? obsecureText,
    final Color? backgroundColor,
    final Color? borderColor,
    final double? borderRadius,
    final TextStyle? hintStyle,
  }) {
    return TextFieldWidget(
      title: title,
      controller: controller,
      enable: enable,
      hintText: hintText,
      errorText: errorText,
      maxLength: maxLength,
      ontap: ontap,
      multiline: false,
      suffixIcon: suffixIcon,
      readOnly: readOnly,
      showCursor: showCursor,
      lineCount: 1,
      textAlignVertical: textAlignVertical,
      labelText: labelText,
      labelStyle: labelStyle,
      prefixIcon: prefixIcon,
      padding: padding,
      inputFormatter: inputFormatter,
      keyboardType: keyboardType,
      onChanged: onChanged,
      focusNode: focusNode,
      height: height,
      scrollPadding: scrollPadding,
      prefixPadding: prefixPadding,
      onSuffixIconPressed: onSuffixIconPressed,
      obsecureText: obsecureText,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadious: borderRadius ?? 8,
      hintStyle: hintStyle,
    );
  }

  factory TextFieldWidget.multiline({
    required final TextEditingController controller,
    final String? title,
    required final int? maxLength,
    required final int? lineCount,
    final TextStyle? titleTextStyle,
    final Widget? prefixIcon,
    final TextStyle? labelStyle,
    final EdgeInsets? padding,
    final String? errorText,
    final String? labelText,
    final String? hintText,
    final VoidCallback? ontap,
    final EdgeInsets? scrollPadding,
    final EdgeInsets? contentPadding,
    final EdgeInsets? prefixPadding,
    final TextAlignVertical? textAlignVertical,
    final Function(String value)? onChanged,
  }) {
    return TextFieldWidget(
      titleTextStyle: titleTextStyle,
      padding: padding,
      labelText: labelText,
      labelStyle: labelStyle,
      title: title,
      prefixIcon: prefixIcon,
      controller: controller,
      hintText: hintText,
      errorText: errorText,
      maxLength: maxLength,
      ontap: ontap,
      lineCount: lineCount,
      scrollPadding: scrollPadding,
      contentPadding: contentPadding,
      prefixPadding: prefixPadding,
      multiline: true,
      textAlignVertical: textAlignVertical,
      onChanged: onChanged,
    );
  }

  final double borderRadious;
  final String? title;
  final TextStyle? titleTextStyle;
  final TextEditingController controller;
  final String? errorText;
  final String? hintText;
  final int? maxLength;
  final VoidCallback? ontap;
  final int? lineCount;
  final EdgeInsets? scrollPadding;
  final EdgeInsets? contentPadding;
  final bool multiline;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool? obsecureText;
  final bool enable;
  final bool showCursor;
  final TextAlignVertical? textAlignVertical;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final EdgeInsets? padding;
  final TextInputFormatter? inputFormatter;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final FocusNode? focusNode;
  final double? height;
  final VoidCallback? onSuffixIconPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? prefixPadding;
  final TextStyle? hintStyle;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Container(
            padding: padding ??
                const EdgeInsets.only(
                  left: Spacing.xlarge,
                  right: Spacing.xlarge,
                ),
            child: Text(
              title!,
              style: titleTextStyle ??
                  TextStyles.pro12.copyWith(color: SGColors.blackShade1),
            ),
          ),
          const SizedBox(height: Spacing.small),
        ],
        Container(
          // color: Colors.redAccent,
          height: height,
          margin:
              padding ?? const EdgeInsets.symmetric(horizontal: Spacing.xlarge),
          child: TextField(
            obscureText: obsecureText ?? false,
            enabled: enable,
            focusNode: focusNode,
            readOnly: readOnly,
            showCursor: showCursor,
            cursorColor: SGColors.black,
            maxLines: multiline ? null : lineCount ?? 1,
            maxLength: maxLength,
            controller: controller,
            inputFormatters: inputFormatter != null
                ? <TextInputFormatter>[inputFormatter!]
                : null,
            keyboardType: keyboardType,
            scrollPadding:
                scrollPadding ?? const EdgeInsets.all(Spacing.xlarge),
            textAlignVertical: textAlignVertical,
            onChanged: (final String value) {
              onChanged?.call(value);
              String result = value;
              if (maxLength != null) {
                if (result.length > maxLength!) {
                  result = result.substring(0, maxLength);
                  controller.text = result;
                  controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: result.length),
                  );
                }
              }
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor ?? SGColors.whiteShade3,
                ),
              ),
              filled: backgroundColor != null ? true : false,
              fillColor: backgroundColor,
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: prefixPadding ??
                          const EdgeInsets.symmetric(
                            horizontal: Spacing.large,
                          ),
                      child: prefixIcon,
                    )
                  : null,
              labelText: labelText,
              labelStyle: labelStyle ??
                  const TextStyle(color: SGColors.black, fontSize: 14),
              errorText: errorText,
              errorStyle:
                  TextStyles.pro12.copyWith(color: SGColors.secondaryRed),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor ?? SGColors.blackShade3,
                ),
              ),
              suffixIcon: suffixIcon != null
                  //controller.text.isNotEmpty && was here in the condition
                  ? GestureDetector(
                      onTap: onSuffixIconPressed,
                      child: suffixIcon,
                    )
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
                borderSide: BorderSide(
                  width: 2,
                  color: borderColor ?? SGColors.blackShade1,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadious)),
                borderSide: BorderSide(
                  width: 1,
                  color: borderColor ?? SGColors.blackShade3,
                ),
              ),
              contentPadding: contentPadding ??
                  const EdgeInsets.only(
                    left: Spacing.large,
                    right: Spacing.large,
                  ),
              hintText: hintText,
              hintStyle: hintStyle,
            ),
            onTap: ontap,
          ),
        ),
      ],
    );
  }
}
