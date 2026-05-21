part of '../view.dart';

class _SecurityDrawerMenu extends StatelessWidget {
  final KThemeBox currentTheme;
  final List<SubServices> subServices;
  final int activeIndex;
  final ValueChanged<int> onItemTap;

  const _SecurityDrawerMenu({
    required this.currentTheme,
    required this.subServices,
    required this.activeIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        60.toVerticalSizedBox,
        KDrawerHeader(),
        20.toVerticalSizedBox,
        KDivider(color: Colors.grey, padding: EdgeInsets.zero),
        20.toVerticalSizedBox,
        Padding(
          padding: EdgeInsets.only(left: 10.toAutoScaledWidth),
          child: Row(
            children: [
              const Icon(Icons.security_outlined),
              16.toHorizontalSizedBox,
              Text(
                'Security Services',
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
            itemCount: subServices.length,
            separatorBuilder: (_, __) => const SizedBox(height: 4),
            itemBuilder: (context, index) {
              final type = _securityTypeFromName(
                subServices[index].subServiceName,
              );
              final label =
                  type?.title ??
                  subServices[index].subServiceName ??
                  'Security Services';

              return DrawerMenuItem(
                data: DrawerItemData(
                  index: index,
                  icon: type?.icon ?? Icons.security_outlined,
                  label: label,
                ),
                isSelected: index == activeIndex,
                currentTheme: currentTheme,
                onTap: () => onItemTap(index),
              );
            },
          ),
        ),
      ],
    );
  }
}
