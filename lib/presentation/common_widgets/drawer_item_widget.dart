import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/domain/core/theme/theme.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KDrawerHeader extends ConsumerWidget {
  const KDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;
    final user = KAppX.globalProvider.read(userProvider);

    return Padding(
      padding: EdgeInsets.only(left: 16.toAutoScaledWidth),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircularTextAvatar(
            text: user?.employeeName ?? '',
            width: 32.toAutoScaledWidth,
          ),
          16.toHorizontalSizedBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.employeeName ?? '',
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s18,
                  fontWeight: currentTheme.fontWeights.wBolder,
                  color: currentTheme.colors.onBackground,
                ),
              ),
              SizedBox(
                width: 180.toAutoScaledHeight,
                child: Text(
                  user?.email ?? '',
                  style: TextStyle(
                    fontSize: currentTheme.fontSizes.s12,
                    fontWeight: currentTheme.fontWeights.wRegular,
                    color: currentTheme.colors.onBackground,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              KAppX.router.pop();
            },
            icon: Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}

class CircularTextAvatar extends ConsumerWidget {
  final String text;

  final double width;

  CircularTextAvatar({required this.text, required this.width});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return Container(
      width: width,
      height: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: currentTheme.colors.primary,
        shape: BoxShape.circle,
      ),
      child: text != ''
          ? Text(
              text.substring(0, 1).toUpperCase() ?? '',

              // state.activityList[index].username!.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: currentTheme.fontSizes.s16,
              ),
            )
          : Text(
              '',

              // state.activityList[index].username!.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: currentTheme.fontSizes.s16,
              ),
            ),
    );
  }
}

class DrawerItemData {
  final int index;
  final IconData icon;
  final String label;

  const DrawerItemData({
    required this.index,
    required this.icon,
    required this.label,
  });
}

class DrawerMenuItem extends StatelessWidget {
  final DrawerItemData data;
  final bool isSelected;
  final KThemeBox currentTheme;
  final VoidCallback onTap;

  const DrawerMenuItem({
    required this.data,
    required this.isSelected,
    required this.currentTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected
        ? currentTheme.colors.primary.withOpacity(0.08)
        : Colors.transparent;

    final iconColor = isSelected
        ? currentTheme.colors.primary
        : currentTheme.colors.onBackground;

    final textColor = iconColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.toAutoScaledWidth),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16.toAutoScaledWidth,
          vertical: 4.toAutoScaledHeight,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.toAutoScaledWidth,
          vertical: 10.toAutoScaledHeight,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.toAutoScaledWidth),
        ),
        child: Row(
          children: [
            Icon(data.icon, size: 22.toAutoScaledWidth, color: iconColor),
            12.toHorizontalSizedBox,
            Expanded(
              child: Text(
                data.label,
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: isSelected
                      ? currentTheme.fontWeights.wBold
                      : currentTheme.fontWeights.wRegular,
                  color: textColor,
                  // fontFamily: GoogleFonts.mitr().fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
