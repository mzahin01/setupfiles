import 'package:flutter_svg/flutter_svg.dart';

class MaxSvgImage extends SvgPicture {
  MaxSvgImage.asset(super.assetName,
      {super.height,
      super.alignment,
      super.allowDrawingOutsideViewBox,
      super.bundle,
      super.clipBehavior,
      super.colorFilter,
      super.excludeFromSemantics,
      super.fit,
      super.theme,
      super.width,
      super.placeholderBuilder,
      super.semanticsLabel,
      super.matchTextDirection,
      super.package,
      super.key})
      : super.asset();
}
