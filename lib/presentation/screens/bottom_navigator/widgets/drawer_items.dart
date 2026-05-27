part of '../view.dart';

/// ----------------------
/// Drawer menu widget
/// ----------------------
class _DrawerMenu extends StatelessWidget {
  final KThemeBox currentTheme;
  final int activeIndex;
  final ValueChanged<int> onItemTap;

  const _DrawerMenu({
    required this.currentTheme,
    required this.activeIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = const [
      DrawerItemData(
        index: 0,
        icon: Icons.access_time,
        label: 'Attendance & Info',
      ),
      DrawerItemData(
        index: 1,
        icon: Icons.assignment_outlined,
        label: 'Leave Portal (Request for Leave)',
      ),
      DrawerItemData(
        index: 2,
        icon: Icons.nightlight_round,
        label: 'Request for stay after working hours',
      ),
    ];
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Header / profile section
        60.toVerticalSizedBox,
        KDrawerHeader(),
        20.toVerticalSizedBox,

        KDivider(color: Colors.grey, padding: EdgeInsets.zero),
        20.toVerticalSizedBox,

        Padding(
          padding: EdgeInsets.only(left: 10.toAutoScaledWidth),
          child: Row(
            children: [
              Icon(Icons.people_alt_outlined),
              16.toHorizontalSizedBox,
              Text(
                'HR Services',
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s16,
                  fontWeight: currentTheme.fontWeights.wBolder,
                  color: currentTheme.colors.onBackground,
                ),
              ),
            ],
          ),
        ),
        10.toVerticalSizedBox,

        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, i) {
              final item = items[i];
              final bool isSelected = item.index == activeIndex;

              return DrawerMenuItem(
                data: item,
                isSelected: isSelected,
                currentTheme: currentTheme,
                onTap: () => onItemTap(item.index),
              );
            },
          ),
        ),
      ],
    );
  }
}
