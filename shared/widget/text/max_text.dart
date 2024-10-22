// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'max_text_types.dart';

class MaxText extends StatelessWidget {
  final title;
  final TextStyle? style;
  final MaxTextTypes? type;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLine;
  final bool? softWrap;
  final int? maxLength;
  final StrutStyle? strutStyle;

  const MaxText(this.title,
      {super.key,
      this.style,
      this.maxLine,
      this.type,
      this.color,
      this.textAlign,
      this.strutStyle,
      this.overflow,
      this.maxLength,
      this.softWrap})
      : assert(style == null || type == null,
            'please provide either style or type');

  @override
  Widget build(BuildContext context) {
    var newText;
    if (maxLength != null) {
      newText =
          (title.length > maxLength ? title.substring(0, maxLength) : title) +
              "...";
    }
    return Text(
      newText ?? title ?? "",
      style: getStyle(context),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: softWrap,
      maxLines: maxLine,
      strutStyle: strutStyle,
    );
  }

  getStyle(context) {
    if (style != null) {
      return style?.copyWith(color: color);
    }

    var textTheme = Theme.of(context).textTheme;

    switch (type) {
      case MaxTextTypes.bodyLarge:
        return textTheme.bodyLarge?.copyWith(color: color);
      case MaxTextTypes.bodyMedium:
        return textTheme.bodyMedium?.copyWith(color: color);
      case MaxTextTypes.bodySmall:
        return textTheme.bodySmall?.copyWith(color: color);

      case MaxTextTypes.labelLarge:
        return textTheme.labelLarge?.copyWith(color: color);
      case MaxTextTypes.labelMedium:
        return textTheme.labelMedium?.copyWith(color: color);
      case MaxTextTypes.labelSmall:
        return textTheme.labelSmall?.copyWith(color: color);

      case MaxTextTypes.titleLarge:
        return textTheme.titleLarge?.copyWith(color: color);
      case MaxTextTypes.titleMedium:
        return textTheme.titleMedium?.copyWith(color: color);
      case MaxTextTypes.titleSmall:
        return textTheme.titleSmall?.copyWith(color: color);

      case MaxTextTypes.headlineLarge:
        return textTheme.headlineLarge?.copyWith(color: color);
      case MaxTextTypes.headlineMedium:
        return textTheme.headlineMedium?.copyWith(color: color);
      case MaxTextTypes.headlineSmall:
        return textTheme.headlineSmall?.copyWith(color: color);

      case MaxTextTypes.displayLarge:
        return textTheme.displayLarge?.copyWith(color: color);
      case MaxTextTypes.displayMedium:
        return textTheme.displayMedium?.copyWith(color: color);
      case MaxTextTypes.displaySmall:
        return textTheme.displaySmall?.copyWith(color: color);

      default:
        return TextStyle(color: color);
    }
  }
}
