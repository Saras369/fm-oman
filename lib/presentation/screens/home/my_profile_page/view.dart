import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/home/view.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/utils/data_type_extensions/data_type_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'widget/announcement_card.dart';
part 'controller.dart';

@RoutePage()
class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider);
    final stateController = ref.read(_vsProvider.notifier);
    final user = ref.read(userProvider);
    final currentTheme = ref.read(KAppX.theme.current).themeBox;
    return KScaffold(
      appBar: KAppBar(
        title: Text(
          '    ${stateController.getGreetingMessage()}, ${user?.employeeName ?? ''}!',

          style: TextStyle(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s16,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyProfileWidget(),
              AnnouncementsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
