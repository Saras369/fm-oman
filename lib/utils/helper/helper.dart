import 'dart:async';

part 'debounce.dart';
part 'throttle.dart';

final RegExp hashtagRegExp = RegExp(r'\B#\w+\b');
final RegExp mentionRegExp = RegExp(r'\B@\w+\b');
