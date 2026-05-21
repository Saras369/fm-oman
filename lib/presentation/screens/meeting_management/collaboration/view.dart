import 'package:auto_route/auto_route.dart';
import 'package:code_setup/modules/data/models/all_services_model.dart';
import 'package:code_setup/modules/data/models/attendance_management/my_attendance_request_model.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

import 'package:code_setup/modules/data/models/meeting_management/conversation_model.dart';
import 'package:code_setup/repository/domain/meeting_management_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:code_setup/modules/data/core/storage/auth_cred.dart';
import 'package:code_setup/presentation/screens/meeting_management/collaboration/widgets/new_chat_view.dart';

part 'controller.dart';
part 'widgets/collaboration_inbox_view.dart';
part 'widgets/collaboration_chat_view.dart';

@RoutePage()
class CollaborationScreen extends ConsumerWidget {
  final List<SubServices> subServicesList;
  final int serviceId;
  late final _VSControllerParams params;

  CollaborationScreen({
    super.key,
    required this.subServicesList,
    required this.serviceId,
  }) {
    params = _VSControllerParams(
      subServicesList: subServicesList,
      serviceId: serviceId,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_vsProvider(params));

    return KScaffold(
      body: SafeArea(
        child: state.selectedContact == null
            ? CollaborationInboxView(params: params)
            : CollaborationChatView(params: params),
      ),
    );
  }
}
