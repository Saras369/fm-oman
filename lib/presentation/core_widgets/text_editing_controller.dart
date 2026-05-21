import 'package:flutter/material.dart';

import '../../utils/app_extensions/app_extension.dart';

final _currentTheme = KAppX.globalProvider.read(KAppX.theme.current).themeBox;

class KTextEditingController extends TextEditingController {
  final Map<RegExp, TextStyle>? patternMatchMap;
  final Map<String, TextStyle>? stringMatchMap;
  final Function(List<String> match) onMatch;
  final Function(List<Map<String, List<int>>>)? onMatchIndex;
  final bool deleteOnBack;
  String _lastValue = '';
  final bool regExpCaseSensitive;
  final bool regExpDotAll;
  final bool regExpMultiLine;
  final bool regExpUnicode;
  Map<String, int> hashtagCounts = {}; // Store hashtag counts

  bool isBack(String current, String last) {
    return current.length < last.length;
  }

  KTextEditingController({
    super.text,
    this.patternMatchMap,
    this.stringMatchMap,
    required this.onMatch,
    this.onMatchIndex,
    this.deleteOnBack = false,
    this.regExpCaseSensitive = true,
    this.regExpDotAll = false,
    this.regExpMultiLine = false,
    this.regExpUnicode = false,
  }) : assert(
         (patternMatchMap != null && stringMatchMap == null) ||
             (patternMatchMap == null && stringMatchMap != null),
       );

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: const TextSelection.collapsed(offset: -1),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    List<TextSpan> children = [];
    final matches = <String>[];
    List<Map<String, List<int>>> matchIndex = [];

    text.splitMapJoin(
      patternMatchMap != null
          ? patternMatchMap!.keys.first
          : stringMatchMap!.keys.first,
      onNonMatch: (String span) {
        children.add(TextSpan(text: span, style: style));
        return span.toString();
      },
      onMatch: (Match m) {
        final isPressingBack =
            (isBack(text, _lastValue) && m.end == selection.baseOffset);

        if (isPressingBack && deleteOnBack) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            children.removeWhere((element) => element.text! == text);
            text = text.replaceRange(m.start, m.end, '');
            selection = selection.copyWith(
              baseOffset: m.end - (m.end - m.start),
              extentOffset: m.end - (m.end - m.start),
            );
          });
        } else {
          String? matchText = m[0];
          matches.add(matchText!);

          if (matchText.startsWith('#')) {
            children.add(
              TextSpan(
                text: matchText,
                style: TextStyle(color: _currentTheme.colors.primary),
              ),
            );
          } else if (matchText.endsWith('#')) {
            matchText = '$matchText';
          } else {
            children.add(TextSpan(text: matchText, style: style));
          }
        }
        final resultMatchIndex = matchValueIndex(m);
        if (resultMatchIndex != null && onMatchIndex != null) {
          matchIndex.add(resultMatchIndex);
          onMatchIndex!(matchIndex);
        }

        return (onMatch(matches) ?? '');
      },
    );

    _lastValue = text;
    return TextSpan(style: style, children: children);
  }

  Map<String, List<int>>? matchValueIndex(Match match) {
    final matchValue = match[0]?.replaceFirstMapped('#', (match) => '');
    if (matchValue != null) {
      final firstMatchChar = match.start + 1;
      final lastMatchChar = match.end - 1;
      final compactMatch = {
        matchValue: [firstMatchChar, lastMatchChar],
      };
      return compactMatch;
    }
    return null;
  }
}
