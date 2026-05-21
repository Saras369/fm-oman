import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_extensions/app_extension.dart';
import '../loader/circular_loader.dart';

typedef KCachedImageProviderError =
    Widget Function(BuildContext, String, dynamic);
typedef KCachedImageProviderPlaceHolder = Widget Function(BuildContext, String);
typedef KCachedImageProviderImageBuilder =
    Widget Function(BuildContext, ImageProvider<Object>);

class KCachedImageProvider extends ConsumerWidget {
  final String imageUrl;
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

  const KCachedImageProvider(
    this.imageUrl, {
    Key? key,
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
    this.resize = true,
    this.tintColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      final currentTheme = ref.watch(KAppX.theme.current).themeBox;

      final widget = CachedNetworkImage(
        cacheKey: imageUrl,
        imageUrl: imageUrl,
        fadeInDuration: fadeInDuration ?? Duration(milliseconds: 200),
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
          color: tintColor,
        ),
        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            color: backgroundColor,
            child: Align(
              alignment: loaderAlignment ?? Alignment.center,
              child: SizedBox(
                width: (height ?? 1.8) / 1.8,
                height: (height ?? 1.8) / 1.8,
                child:
                    loader ??
                    Center(
                      child: KCircularLoader(
                        color: currentTheme.colors.secondary.shade90,
                      ),
                    ),
              ),
            ),
          );
        },
        errorWidget: (context, error, stackTrace) {
          return Container(
            color: backgroundColor,
            child: Center(
              child: Icon(Icons.broken_image, size: 32),
              // child: Image.asset(
              //   KIcons.brokenImg,
              //   width: 32.toAutoScaledWidth,
              //   height: 32.toAutoScaledHeight,
              // ),
            ),
          );
        },
      );

      if (borderRadius != null) {
        return ClipRRect(borderRadius: borderRadius!, child: widget);
      } else {
        return widget;
      }
    } catch (e) {
      // Handle any exceptions here
      print('Exception occurred: $e');
      return Container(); // or return a placeholder widget if needed
    }
  }
}
