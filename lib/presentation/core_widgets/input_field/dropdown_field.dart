import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_extensions/app_extension.dart';

typedef KDropdownSelectedItemBuilder<T> =
    List<Widget> Function(BuildContext context, List<KDropdownItem<T>> items);

class KDropdownField<T> extends ConsumerWidget {
  final Widget? fieldHeading;
  final String? fieldHeadingText;
  final TextStyle? fieldHeadingTextStyle;
  final List<KDropdownItem<T>> items;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?> onChanged;
  final VoidCallback? onTap;
  final KDropdownSelectedItemBuilder<T>? selectedItemBuilder;
  final int elevation;
  final TextStyle? style;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double? iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? dropdownColor;
  final double? menuMaxHeight;
  final bool enableFeedback;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final InputDecoration? decoration;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final String? hintText;
  final String? errorText;
  final bool? isRequired;
  const KDropdownField({
    Key? key,
    this.fieldHeading,
    this.fieldHeadingText,
    this.fieldHeadingTextStyle,
    this.value,
    required this.items,
    this.selectedItemBuilder,
    this.hint,
    this.disabledHint,
    required this.onChanged,
    this.onTap,
    this.elevation = 8,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize,
    this.isDense = true,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback = true,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.decoration,
    this.backgroundColor,
    this.hintText,
    this.borderColor,
    this.errorText,
    this.focusedBorderColor,
    this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return Padding(
      padding: EdgeInsets.only(bottom: 15.toAutoScaledHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldHeadingText != null || fieldHeading != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldHeading ??
                        RichText(
                          text: TextSpan(
                            text: fieldHeadingText!,
                            style: TextStyle(
                              color: currentTheme.colors.secondary.shade30,
                              fontSize: currentTheme.fontSizes.s12,
                              fontWeight: currentTheme.fontWeights.wBolder,
                            ).merge(fieldHeadingTextStyle),
                            children: isRequired == true
                                ? [
                                    TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: currentTheme.fontSizes.s12,
                                      ),
                                    ),
                                  ]
                                : [],
                          ),
                        ),

                    // Text(
                    //   fieldHeadingText!,
                    //   style: TextStyle(
                    //     color: currentTheme.colors.secondary.shade30,
                    //     fontSize: currentTheme.fontSizes.s12,
                    //     fontWeight: currentTheme.fontWeights.wBolder,
                    //   ).merge(fieldHeadingTextStyle),
                    // ),
                    8.toVerticalSizedBox,
                  ],
                )
              : SizedBox(),
          DropdownButtonFormField<T>(
            value: value,
            items: items.map<DropdownMenuItem<T>>((item) => item).toList(),
            selectedItemBuilder: selectedItemBuilder != null
                ? (BuildContext context) {
                    return selectedItemBuilder!.call(context, items);
                  }
                : null,
            hint: hint,
            disabledHint: disabledHint,
            onChanged: (value) {
              if (enableFeedback) {
                KAppX.services.haptics.hapticLight();

                Feedback.forTap(context);
              }

              onChanged.call(value);
            },
            onTap: () {
              if (enableFeedback) {
                KAppX.services.haptics.hapticLight();

                Feedback.forTap(context);
              }

              onTap?.call();
            },
            elevation: elevation,
            style: TextStyle(
              fontSize: currentTheme.fontSizes.s12,
              fontWeight: currentTheme.fontWeights.wRegular,
              color: currentTheme.colors.onBackground,
            ).merge(style),
            icon:
                icon ??
                Padding(
                  padding: EdgeInsets.only(left: currentTheme.paddings.v4),
                  child: Icon(
                    CupertinoIcons.chevron_down,
                    size: 16.toAutoScaledWidth,
                    color: currentTheme.colors.onBackground,
                  ),
                  // KImageProvider(
                  //   image: KIcons.cupertino_arrow_down,
                  //   width: 24.toAutoScaledWidth,
                  //   height: 24.toAutoScaledHeight,
                  //   tintColor: currentTheme.colors.onBackground,
                  // ),
                ),
            iconDisabledColor: currentTheme.colors.secondary.shade90,
            iconEnabledColor: currentTheme.colors.secondary,
            iconSize: iconSize ?? 24.toAutoScaledWidth,
            isDense: isDense,
            isExpanded: isExpanded,
            itemHeight: itemHeight,
            focusColor:
                focusColor ?? dropdownColor ?? currentTheme.colors.background,
            focusNode: focusNode,
            autofocus: autofocus,
            dropdownColor: dropdownColor ?? currentTheme.colors.background,
            menuMaxHeight: menuMaxHeight,
            alignment: alignment,
            borderRadius: borderRadius,
            decoration:
                InputDecoration(
                  filled: true,
                  fillColor: backgroundColor ?? currentTheme.colors.background,
                  hintText: hintText,
                  hintStyle: TextStyle(
                    //TODO: font-family lato
                    color: currentTheme.colors.secondary.shade60,
                    fontSize: currentTheme.fontSizes.s12,
                    fontWeight: currentTheme.fontWeights.wRegular,
                  ),
                  errorText: errorText,
                  errorStyle:
                      decoration?.errorStyle ??
                      TextStyle(
                        color:
                            Colors.red, // Or default from theme to make visible
                        fontSize: currentTheme.fontSizes.s12,
                      ),

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: currentTheme.paddings.h12,
                    vertical: 11.5.toAutoScaledHeight,
                  ),
                  border: _buildOutlineInputBorder(
                    color: borderColor ?? currentTheme.colors.secondary.shade90,
                  ),
                  focusedBorder: _buildOutlineInputBorder(
                    color:
                        focusedBorderColor ??
                        currentTheme.colors.secondary.shade90,
                  ),
                  errorBorder: _buildOutlineInputBorder(
                    color: currentTheme.colors.error,
                  ),
                  focusedErrorBorder: _buildOutlineInputBorder(
                    color: currentTheme.colors.error,
                  ),
                  enabledBorder: _buildOutlineInputBorder(
                    color: borderColor ?? currentTheme.colors.secondary.shade90,
                  ),
                  disabledBorder: _buildOutlineInputBorder(
                    color:
                        borderColor?.withOpacity(0.5) ??
                        currentTheme.colors.secondary.shade90.withOpacity(0.5),
                  ),
                ).copyWith(
                  fillColor: decoration?.fillColor,
                  hintStyle: decoration?.hintStyle,
                  contentPadding: decoration?.contentPadding,
                  border: decoration?.border,
                  focusedBorder: decoration?.focusedBorder,
                  errorBorder: decoration?.errorBorder,
                  focusedErrorBorder: decoration?.focusedErrorBorder,
                  enabledBorder: decoration?.enabledBorder,
                  disabledBorder: decoration?.disabledBorder,
                  prefix: decoration?.prefix,
                  prefixIcon: decoration?.prefixIcon,
                  prefixIconColor: decoration?.prefixIconColor,
                  prefixIconConstraints: decoration?.prefixIconConstraints,
                  prefixStyle: decoration?.prefixStyle,
                  prefixText: decoration?.prefixText,
                  suffix: decoration?.suffix,
                  suffixIcon: decoration?.suffixIcon,
                  suffixIconColor: decoration?.suffixIconColor,
                  suffixIconConstraints: decoration?.suffixIconConstraints,
                  suffixStyle: decoration?.suffixStyle,
                  suffixText: decoration?.suffixText,
                ),
          ),
        ],
      ),
    );
  }

  InputBorder _buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.toAutoScaledWidth),
      borderRadius: BorderRadius.all(Radius.circular(4.toAutoScaledWidth)),
    );
  }
}

class KDropdownItem<T> extends DropdownMenuItem<T> {
  KDropdownItem({
    super.key,
    super.onTap,
    required super.value,
    super.enabled = true,
    super.alignment,
    required super.child,
  });
}
