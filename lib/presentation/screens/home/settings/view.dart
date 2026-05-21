import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/router/app_router.gr.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/locale/app_locale_provider.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/input_field/dropdown_field.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/all_services_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'controller.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsProvider);
    final controller = ref.read(settingsProvider.notifier);

    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      appBar: KAppBar(
        title: Text(
          '    Settings',

          style: TextStyle(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView(
            children: [
              // --------- Theme ----------
              Text(
                'Appearance',
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              8.toVerticalSizedBox,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.brightness_6_rounded,
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Theme',
                            style: TextStyle(
                              fontSize: currentTheme.fontSizes.s14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            state.isDarkMode
                                ? 'Dark mode is enabled'
                                : 'Light mode is enabled',
                            style: TextStyle(
                              fontSize: currentTheme.fontSizes.s12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: state.isDarkMode,
                      onChanged: controller.onToggleTheme,
                    ),
                  ],
                ),
              ),

              24.toVerticalSizedBox,

              // --------- Role ----------
              Text(
                'Account',
                style: TextStyle(
                  fontSize: currentTheme.fontSizes.s14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              8.toVerticalSizedBox,
              KDropdownField<RoleDetails>(
                value: state.selectedRole.role?.id != null
                    ? state.selectedRole
                    : null,
                fieldHeadingText: 'Select Role',
                hintText: 'Choose your active role',
                items: state.rolesList
                    .map<KDropdownItem<RoleDetails>>(
                      (role) => KDropdownItem<RoleDetails>(
                        value: role,
                        child: Text(role.role?.name ?? ''),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    controller.onSelectRole(v);
                  }
                },
              ),

              16.toVerticalSizedBox,

              // --------- Language ----------
              KDropdownField<LanguageItem>(
                value: state.selectedLanguage,
                fieldHeadingText: 'Language',
                hintText: 'Select language',
                items: state.languageList
                    .map<KDropdownItem<LanguageItem>>(
                      (lang) => KDropdownItem<LanguageItem>(
                        value: lang,
                        child: Text(lang.name),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    controller.onSelectLanguage(v);
                  }
                },
              ),

              32.toVerticalSizedBox,

              // --------- Logout ----------
              8.toVerticalSizedBox,
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: state.isLoggingOut
                      ? null
                      : () => controller.onLogoutPressed(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: Text(
                    state.isLoggingOut ? 'Logging out...' : 'Logout',
                    style: TextStyle(
                      fontSize: currentTheme.fontSizes.s14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
