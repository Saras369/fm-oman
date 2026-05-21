import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

part 'data_types/color.dart';
part 'data_types/date_time.dart';
part 'data_types/duration.dart';
part 'data_types/int.dart';
part 'data_types/iterable.dart';
part 'data_types/string.dart';

class ValidX {
  final String? error;
  final bool isValid;

  ValidX._({this.error, required this.isValid});

  factory ValidX.isValid() => ValidX._(isValid: true);

  factory ValidX.isNotValid({required String error}) =>
      ValidX._(error: error, isValid: false);
}
