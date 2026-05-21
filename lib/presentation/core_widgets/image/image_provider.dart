import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_extensions/app_extension.dart';
import 'cached_image_provider.dart';

class KImageProvider extends ConsumerWidget {
  final String? image;
  final Uint8List? bytes;
  final Color? backgroundColor;
  final Duration? fadeInDuration;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Widget? loader;
  final Alignment? loaderAlignment;
  final double? loaderSize;
  final KCachedImageProviderError? errorWidget;
  final KCachedImageProviderPlaceHolder? placeholder;
  final KCachedImageProviderImageBuilder? imageBuilder;
  final bool? resize;
  final Color? tintColor;
  const KImageProvider({
    Key? key,
    this.image,
    this.bytes,
    this.backgroundColor,
    this.fadeInDuration,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.loader,
    this.loaderAlignment,
    this.loaderSize,
    this.errorWidget,
    this.placeholder,
    this.imageBuilder,
    this.resize,
    this.tintColor,
  }) : assert(
         (image != null && bytes == null) ||
             (image == null && bytes != null) ||
             (image == null && bytes == null),
       ),
       super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;
    final _backgroundColor =
        backgroundColor ?? currentTheme.colors.secondary.shade95;
    final isBytes = bytes != null;

    return () {
      if (isBytes) {
        return Image.memory(
          bytes!,
          width: width,
          height: height,
          color: tintColor,
          fit: fit,
        );
      } else if (image != null) {
        final isSvg = image?.endsWith('.svg') ?? false;
        final isUrl = image?.startsWith('http') ?? false;

        if (isSvg) {
          return SvgPicture.asset(
            image!,
            width: width,
            height: height,
            color: tintColor,
            fit: fit ?? BoxFit.contain,
          );
        } else if (isUrl) {
          return KCachedImageProvider(
            image!,
            backgroundColor: _backgroundColor,
            fadeInDuration: fadeInDuration,
            width: width,
            height: height,
            fit: fit,
            borderRadius: borderRadius,
            loader: loader,
            loaderAlignment: loaderAlignment,
            loaderSize: loaderSize,
            errorWidget: errorWidget,
            placeholder: placeholder,
            imageBuilder: imageBuilder,
            resize: resize,
            tintColor: tintColor,
          );
        } else {
          return Image.asset(
            image!,
            width: width,
            height: height,
            fit: fit,
            color: tintColor,
          );
        }
      } else {
        final placeHolderSize = () {
          final maxSize = 86.toAutoScaledHeight;
          final _width = (width ?? 3) / 3;
          final _height = (height ?? 3) / 3;

          if (_width > maxSize && _height > maxSize) {
            return maxSize;
          }

          if (_width < _height) {
            return _width;
          }

          return _height;
        }();

        ///Placeholder
        return Container(
          width: width,
          height: height,
          color: _backgroundColor,
          child: Center(
            child: SizedBox(
              width: placeHolderSize,
              height: placeHolderSize,
              child: Placeholder(),
            ),
            // SvgPicture.asset(
            //   KIcons.image_placeholder,
            //   width: placeHolderSize,
            //   height: placeHolderSize,
            //   fit: fit ?? BoxFit.contain,
            // ),
          ),
        );
      }
    }();
  }
}
