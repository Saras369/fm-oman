import 'package:code_setup/presentation/core_widgets/input_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';

import '../../../utils/app_extensions/app_extension.dart';

class KSearchBar extends ConsumerStatefulWidget {
  final bool autofocus;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final bool showClearButton;
  const KSearchBar({
    Key? key,
    this.autofocus = true,
    this.controller,
    required this.onChanged,
    this.hintText,
    this.autofillHints,
    this.showClearButton = false,
  }) : super(key: key);

  @override
  ConsumerState createState() => _KSearchBarState();
}

class _KSearchBarState extends ConsumerState<KSearchBar> {
  final ValueNotifier<bool> isCrossBtnVisible = ValueNotifier(false);

  @override
  void initState() {
    widget.controller?.addListener(() {
      isCrossBtnVisible.value =
          widget.controller?.text.trim().isNotEmpty ?? false;
    });
    super.initState();
  }

  void clearTextField() {
    widget.controller?.text = '';

    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(KAppX.theme.current).themeBox;

    return KTextField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      hintText: widget.hintText ?? 'Search',
      onChanged: widget.onChanged,
      autofillHints: widget.autofillHints,
      style: TextStyle(
        height: 20.2.toAutoScaledFont / currentTheme.fontSizes.s14,
      ),
      decoration: InputDecoration(
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            12.toHorizontalSizedBox,
            Icon(Icons.search, size: 20),
            8.toHorizontalSizedBox,
          ],
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0),
        // suffixIcon: ValueListenableBuilder<bool>(
        //     valueListenable: isCrossBtnVisible,
        //     builder: (context, value, _) {
        //       if (!value) {
        //         return SizedBox();
        //       }

        //       return KClickable(
        //         onPressed: clearTextField,
        //         child: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             KImageProvider(
        //               image: KIcons.cross,
        //               tintColor: currentTheme.colors.onBackground,
        //               width: 24.toAutoScaledWidth,
        //               height: 24.toAutoScaledHeight,
        //             ),
        //             12.toHorizontalSizedBox,
        //           ],
        //         ),
        //       );
        //     }),
        // suffixIconConstraints: BoxConstraints(
        //   minWidth: 0,
        // ),
      ),
    );
  }
}
