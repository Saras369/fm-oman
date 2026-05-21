import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import '../../../utils/app_extensions/app_extension.dart';
import '../../../utils/assets/icons.dart';
import '../image/image_provider.dart';

class MobileNumberInputField extends ConsumerWidget {
  final TextEditingController mobileInputController;
  final FocusNode? focusNode;
  const MobileNumberInputField({
    super.key,
    required this.mobileInputController,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return SizedBox(
      width: 220.toAutoScaledWidth,
      child: TextField(
        onChanged: (value) {
          if (value.length == 10) {
            FocusScope.of(context).unfocus(); // Hide keyboard
          }
        },
        focusNode: focusNode,
        controller: mobileInputController,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allows only numbers
          FilteringTextInputFormatter.deny(
            RegExp(r'[.,]'),
          ), // Blocks '.' and ','
        ],

        style: TextStyle(
          fontSize: currentTheme.fontSizes.s16,
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontWeight: currentTheme.fontWeights.wBold,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 15.toAutoScaledHeight,
          ), // Adjust vertical padding
          prefixIcon: IntrinsicWidth(
            // Auto-adjust width to prevent extra space
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 25.toAutoScaledWidth), // Adjust spacing
                KImageProvider(
                  width: 15.94.toAutoScaledWidth,
                  height: 15.94.toAutoScaledHeight,
                  image: KIcons.indianFlag,
                ),
                SizedBox(width: 3.toAutoScaledWidth), // Reduced space
                Text(
                  '+91',
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s16,
                    fontFamily: GoogleFonts.kanit().fontFamily,
                    fontWeight: currentTheme.fontWeights.wBold,
                    color: currentTheme.colors.secondary,
                  ),
                ),
                SizedBox(width: 15.toAutoScaledWidth), // Further reduced space
              ],
            ),
          ),
          hintText: 'Enter Mobile Number',
          hintStyle: TextStyle(
            color: Color(0xFF595755).withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: currentTheme.fontSizes.s14,
          ),
          counterText: '', // Removes counter text
          prefixIconConstraints: BoxConstraints(
            minWidth: 0, // No extra width added
            minHeight: 48.toAutoScaledHeight,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: currentTheme.colors.primary,
              width: 1.0,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: currentTheme.colors.primary,
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: currentTheme.colors.primary,
              width: 2.0,
            ),
          ),
        ),
        maxLength: 10,
        keyboardType: TextInputType.number,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    );
  }
}
