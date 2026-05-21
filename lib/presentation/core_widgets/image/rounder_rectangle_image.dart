import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'image_provider.dart';

class KRectangleRoundImageProvider extends ConsumerWidget {
  final String? image;
  final Uint8List? bytes;
  final Color? backgroundColor;
  final Duration? fadeInDuration;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? borderRadius;
  final bool? resize;
  const KRectangleRoundImageProvider({
    Key? key,
    this.image,
    this.bytes,
    this.backgroundColor,
    this.fadeInDuration,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.resize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        borderRadius ?? 8.0.toAutoScaledWidth,
      ),
      child: KImageProvider(
        image: image,
        bytes: bytes,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        fadeInDuration: fadeInDuration,
        resize: resize,
      ),
    );
  }
}
