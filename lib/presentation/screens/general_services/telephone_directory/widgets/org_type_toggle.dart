part of '../view.dart';

class _OrgTypeToggle extends ConsumerWidget {
  final OrgType orgType;

  const _OrgTypeToggle({required this.orgType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = Colors.red.shade600;
    final unselectedColor = Colors.grey.shade200;
    final textSelected = Colors.white;
    final textUnselected = Colors.black87;

    Widget buildChip(String label, OrgType value) {
      final isActive = orgType == value;
      final stateController = ref.watch(_vsProvider.notifier);
      return Expanded(
        child: GestureDetector(
          onTap: () {
            stateController.onSelectOrgType(value);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isActive ? selectedColor : unselectedColor,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? textSelected : textUnselected,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        buildChip('FM', OrgType.fm),
        const SizedBox(width: 8),
        buildChip('Embassy', OrgType.embassy),
      ],
    );
  }
}

enum OrgType { fm, embassy }
