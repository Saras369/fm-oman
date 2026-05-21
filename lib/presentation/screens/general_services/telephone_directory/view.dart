import 'package:auto_route/auto_route.dart';
import 'package:code_setup/l10n/app_localizations.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_category_model.dart';
import 'package:code_setup/modules/data/models/helpdesk/helpdesk_sub_category_model.dart';
import 'package:code_setup/modules/data/models/telephone_directory/department_wise_directory_model.dart';
import 'package:code_setup/modules/data/models/telephone_directory/telephone_directory_by_department_model.dart';
import 'package:code_setup/presentation/core_widgets/buttons/action_button.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/input_field/search_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/telephone_directory_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'widgets/org_type_toggle.dart';
part 'widgets/department_chips.dart';
part 'widgets/directory_card.dart';
part 'widgets/telephone_directory_form.dart';
part 'controller.dart';

@RoutePage()
class TelephoneDirectoryScreen extends ConsumerWidget {
  const TelephoneDirectoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final stateController = ref.watch(_vsProvider.notifier);
    final departmentList = state.selectedDepartmentCategory == OrgType.fm
        ? state.departmentCategories.fm
        : state.departmentCategories.embassy;
    final contactsList = state.contactsList;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;
    return KScaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            KSearchBar(onChanged: (String value) {}),
            const SizedBox(height: 12),
            _OrgTypeToggle(orgType: state.selectedDepartmentCategory),
            const SizedBox(height: 12),
            _DepartmentsChips(departments: departmentList ?? []),
            const SizedBox(height: 12),
            Expanded(
              child: contactsList.isEmpty
                  ? const Center(child: Text('No contacts found'))
                  : ListView.separated(
                      itemCount: contactsList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) =>
                          _DirectoryCard(contact: contactsList[index]),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new
          stateController.onPressAddNewContact();
        },
        icon: Icon(Icons.add, color: currentTheme.colors.onPrimary),
        label: Text(
          'Add New',
          style: TextStyle(color: currentTheme.colors.onPrimary),
        ),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }
}
