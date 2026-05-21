import 'package:code_setup/presentation/core_widgets/image/rounder_rectangle_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KAvatarImageProvider extends ConsumerWidget {
  final String? image;
  final Uint8List? bytes;
  final Color? backgroundColor;
  final double size;
  final BoxFit? fit;
  final bool? resize;
  const KAvatarImageProvider({
    Key? key,
    this.image,
    this.bytes,
    this.backgroundColor,
    required this.size,
    this.fit,
    this.resize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KRectangleRoundImageProvider(
      width: size,
      height: size,
      image: image,
      bytes: bytes,
      borderRadius: size / 2,
      backgroundColor: backgroundColor,
      resize: resize,
      fit: fit,
    );
  }
}
