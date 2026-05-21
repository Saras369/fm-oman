import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/image/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_extensions/app_extension.dart';
import '../core_widgets/buttons/action_button.dart';

class ReusableAlertDialog extends ConsumerWidget {
  final String image;
  final String message;
  final String noText;
  final String yesText;
  final double yesWidth;
  final double noWidth;
  final VoidCallback onPressNo;
  final VoidCallback onPressYes;
  final bool isLoading;
  const ReusableAlertDialog({
    super.key,
    required this.image,
    required this.message,
    required this.yesWidth,
    required this.noWidth,
    required this.noText,
    required this.yesText,
    required this.onPressNo,
    required this.onPressYes,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Container(
      padding: EdgeInsets.only(
        left: 20.toAutoScaledWidth,
        right: 20.toAutoScaledWidth,
        top: 20.toAutoScaledHeight,
        bottom: 15.toAutoScaledHeight,
      ),
      width: 346.toAutoScaledWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.toAutoScaledWidth),
      ),
      child: Column(
        children: [
          20.toVerticalSizedBox,
          KImageProvider(
            width: 36.toAutoScaledWidth,
            height: 36.toAutoScaledWidth,
            image: image,
          ),
          20.toVerticalSizedBox,
          Text(
            message,
            style: TextStyle(
              fontFamily: GoogleFonts.lato().fontFamily,
              fontWeight: currentTheme.fontWeights.wBolder,
              fontSize: currentTheme.fontSizes.s16,
              color: currentTheme.colors.secondary,
            ),
          ),
          20.toVerticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onPressNo,
                child: Container(
                  width: noWidth,
                  height: 48.toAutoScaledHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: currentTheme.colors.primary),
                    borderRadius: BorderRadius.circular(32.toAutoScaledWidth),
                    color: currentTheme.colors.onPrimary,
                  ),
                  child: Center(
                    child: Text(
                      noText,
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: currentTheme.fontSizes.s16,
                        fontWeight: currentTheme.fontWeights.wRegular,
                        color: currentTheme.colors.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              20.toHorizontalSizedBox,
              SizedBox(
                width: yesWidth,
                height: 48.toAutoScaledHeight,
                child: KTextActionButton(
                  isLoading: isLoading,
                  // isDisabled: !state.isCountTen,
                  onPressed: onPressYes,
                  text: Text(
                    yesText,
                    style: TextStyle(
                      color: currentTheme.colors.onPrimary,
                      fontSize: currentTheme.fontSizes.s16,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: currentTheme.fontWeights.wRegular,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
