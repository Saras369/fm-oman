import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';

class KTextField extends ConsumerWidget {
  final Widget? fieldHeading;
  final String? fieldHeadingText;
  final TextStyle? fieldHeadingTextStyle;
  final String? initialValue;
  final bool autofocus;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? errorText;
  final bool readOnly;
  final int maxLines;
  final bool isMaxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final Color? cursorColor;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final InputDecoration? decoration;
  final Iterable<String>? autofillHints;
  final bool? enableInteractiveSelection;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextStyle? style;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool? isRequired;

  const KTextField({
    Key? key,
    this.validator,
    this.fieldHeading,
    this.fieldHeadingText,
    this.fieldHeadingTextStyle,
    this.initialValue,
    this.autofocus = false,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.readOnly = false,
    this.maxLines = 1,
    this.isMaxLines = false,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.inputFormatters,
    this.enabled,
    this.onTap,
    this.cursorColor,
    this.hintText,
    this.errorText,
    this.backgroundColor,
    this.borderColor,
    this.focusedBorderColor,
    this.decoration,
    this.autofillHints,
    this.enableInteractiveSelection,
    this.obscureText = false,
    this.style,
    this.suffixIcon,
    this.onSuffixTap,
    this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current);

    return Column(
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
                            color:
                                currentTheme.themeBox.colors.secondary.shade30,
                            fontSize: currentTheme.themeBox.fontSizes.s12,
                            fontWeight:
                                currentTheme.themeBox.fontWeights.wBolder,
                          ).merge(fieldHeadingTextStyle),
                          children: isRequired == true
                              ? [
                                  TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          currentTheme.themeBox.fontSizes.s12,
                                    ),
                                  ),
                                ]
                              : [],
                        ),
                      ),
                  8.toVerticalSizedBox,
                ],
              )
            : SizedBox(),
        TextFormField(
          initialValue: controller == null ? initialValue : null,
          autofocus: autofocus,
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          readOnly: readOnly,
          maxLines: isMaxLines ? null : maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          onChanged: onChanged,
          obscureText: obscureText,
          validator: validator,
          inputFormatters: [
            if (maxLines <= 1) FilteringTextInputFormatter.singleLineFormatter,
            ...?inputFormatters,
          ],
          enabled: enabled,
          cursorColor: cursorColor ?? currentTheme.themeBox.colors.secondary,
          onTap: onTap,
          enableInteractiveSelection: enableInteractiveSelection,
          style: TextStyle(
            //TODO: font-family lato
            color: currentTheme.themeBox.colors.secondary,
            fontSize: currentTheme.themeBox.fontSizes.s12,
            fontWeight: currentTheme.themeBox.fontWeights.wRegular,
          ).merge(style),
          autofillHints: autofillHints,
          decoration:
              InputDecoration(
                suffixIcon: suffixIcon != null
                    ? InkWell(
                        onTap: onSuffixTap,
                        borderRadius: BorderRadius.circular(24),
                        child: suffixIcon,
                      )
                    : decoration?.suffixIcon,

                filled: true,
                fillColor:
                    backgroundColor ?? currentTheme.themeBox.colors.background,
                hintText: hintText,
                hintStyle: TextStyle(
                  //TODO: font-family lato
                  color: currentTheme.themeBox.colors.secondary.shade60,
                  fontSize: currentTheme.themeBox.fontSizes.s12,
                  fontWeight: currentTheme.themeBox.fontWeights.wRegular,
                ),
                // errorText: errorText,
                errorStyle:
                    decoration?.errorStyle ??
                    TextStyle(
                      color:
                          Colors.red, // Or default from theme to make visible
                      fontSize: currentTheme.themeBox.fontSizes.s12,
                    ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: currentTheme.themeBox.paddings.h12,
                  vertical: 11.5.toAutoScaledHeight,
                ),
                border: _buildOutlineInputBorder(
                  color:
                      borderColor ??
                      currentTheme.themeBox.colors.secondary.shade90,
                ),
                focusedBorder: _buildOutlineInputBorder(
                  color:
                      focusedBorderColor ??
                      currentTheme.themeBox.colors.secondary.shade90,
                ),
                errorBorder: _buildOutlineInputBorder(
                  color: currentTheme.themeBox.colors.error,
                ),
                focusedErrorBorder: _buildOutlineInputBorder(
                  color: currentTheme.themeBox.colors.error,
                ),
                enabledBorder: _buildOutlineInputBorder(
                  color:
                      borderColor ??
                      currentTheme.themeBox.colors.secondary.shade90,
                ),
                disabledBorder: _buildOutlineInputBorder(
                  color:
                      borderColor?.withOpacity(0.5) ??
                      currentTheme.themeBox.colors.secondary.shade90
                          .withOpacity(0.5),
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
                counterText: decoration?.counterText,
              ),
        ),
        errorText != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.toVerticalSizedBox,
                  Text(
                    errorText!,
                    style: TextStyle(
                      //TODO: font-family lato
                      color: currentTheme.themeBox.colors.error,
                      fontSize: currentTheme.themeBox.fontSizes.s12,
                      fontWeight: currentTheme.themeBox.fontWeights.wRegular,
                      height:
                          14.4.toAutoScaledFont /
                          currentTheme.themeBox.fontSizes.s12,
                    ).merge(decoration?.errorStyle),
                  ),
                ],
              )
            : SizedBox(),
      ],
    );
  }

  InputBorder _buildOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.toAutoScaledWidth),
      borderRadius: BorderRadius.all(
        Radius.circular(
          // 1.toAutoScaledWidth
          4.toAutoScaledWidth,
        ),
      ),
    );
  }
}
