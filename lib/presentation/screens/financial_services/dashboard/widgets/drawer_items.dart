part of '../view.dart';

class _FinancialDrawerMenu extends StatelessWidget {
  final KThemeBox currentTheme;
  final List<SubServices> subServices;
  final int activeIndex;
  final ValueChanged<int> onItemTap;

  const _FinancialDrawerMenu({
    required this.currentTheme,
    required this.subServices,
    required this.activeIndex,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = _drawerItems;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
              Icon(Icons.account_balance_wallet_outlined),
              16.toHorizontalSizedBox,
              Text(
                'Financial Services',
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
              final isSelected = item.index == activeIndex;

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

  List<DrawerItemData> get _drawerItems {
    final visibleIndexes = _visibleFinancialSubServiceIndexes(subServices);

    if (visibleIndexes.isEmpty) {
      return const [
        DrawerItemData(
          index: 0,
          icon: Icons.account_balance_wallet_outlined,
          label: 'Financial Services',
        ),
      ];
    }

    return visibleIndexes.map((index) {
      final subService = subServices[index];
      return DrawerItemData(
        index: index,
        icon: _iconForSubService(subService.subServiceName),
        label: _financialSubServiceDrawerLabel(subService),
      );
    }).toList();
  }

  IconData _iconForSubService(String? name) {
    final normalizedName = name?.toLowerCase() ?? '';
    if (normalizedName.contains('payslip')) {
      return Icons.receipt_long_outlined;
    }
    if (normalizedName.contains('salary')) {
      return Icons.description_outlined;
    }
    if (normalizedName.contains('allowance')) {
      return Icons.payments_outlined;
    }
    if (normalizedName.contains('reimbursement')) {
      return Icons.request_quote_outlined;
    }
    if (normalizedName.contains('bank')) {
      return Icons.account_balance_outlined;
    }
    return Icons.design_services_outlined;
  }
}
