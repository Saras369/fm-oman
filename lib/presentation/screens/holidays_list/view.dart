import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:code_setup/presentation/core_widgets/app_bar/app_bar.dart';
import 'package:code_setup/presentation/core_widgets/scaffold/scaffold.dart';
import 'package:code_setup/presentation/screens/holidays_list/models/holiday_model.dart';
import 'package:code_setup/repository/data/attendance_repository_impl.dart';
import 'package:code_setup/repository/domain/holidays_repo.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'widgets/holiday_card.dart';
part 'controller.dart';

@RoutePage()
class HolidaysScreen extends StatelessWidget {
  const HolidaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return KScaffold(
      // appBar: KAppBar(
      //   title: Text(
      //     '   Holidays',
      //     style: TextStyle(
      //       fontWeight: currentTheme.fontWeights.wBold,
      //       fontSize: currentTheme.fontSizes.s18,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(child: HolidaysListPage()),
    );
  }
}
