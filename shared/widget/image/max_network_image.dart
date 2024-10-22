import 'package:cached_network_image/cached_network_image.dart';

class MaxNetworkImage extends CachedNetworkImage {
  MaxNetworkImage({
    super.key,
    required super.imageUrl,
    super.httpHeaders,
    super.height,
    super.fit,
    super.imageBuilder,
    super.progressIndicatorBuilder,
    super.placeholder,
    super.errorWidget,
    super.width,
  });
}
