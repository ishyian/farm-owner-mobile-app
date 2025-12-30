import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.errorWidget,
    this.fit = BoxFit.cover,
  });
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? "",
      fit: fit,
      width: width,
      height: height,
      errorWidget: errorWidget == null
          ? null
          : (_, __, ___) {
              return errorWidget!;
            },
      placeholder: (_, __) {
        return const SizedBox(
          width: 50,
          height: 50,
          child: Center(
              child: CircularProgressIndicator(
            color: kPrimaryColor,
          )),
        );
      },
    );
  }
}
