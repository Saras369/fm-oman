part of '../view.dart';

class _DepartmentsChips extends ConsumerWidget {
  final List<DepartmentItem> departments;

  const _DepartmentsChips({required this.departments});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: departments.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final dept = departments[index];
          final isSelected = dept.id == state.selectedDepartementItem.id;

          final stateController = ref.watch(_vsProvider.notifier);

          return GestureDetector(
            onTap: () {
              stateController.onSelectDepartmentOrgItem(dept);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.red.shade600 : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? Colors.red.shade600
                      : Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    dept.name ?? '',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withOpacity(0.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${dept.count ?? 0}',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
