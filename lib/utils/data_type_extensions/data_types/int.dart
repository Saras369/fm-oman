part of '../data_type_extensions.dart';

extension ToExtension on int {
  Color get toColor {
    final h = abs() % 360;

    late double s, l;

    if (h > 45 && h < 195) {
      s = 65 + (h % 16); // range 70 - 85
      l = 60 + (h % 6); // range 60 - 65
    } else {
      s = 60 + (h % 16); // range 60 - 75
      l = 70 + (h % 6); // range 70 - 75
    }

    l = (l / 100);
    s = (s / 100);

    if (s > 1.0) {
      s = s.round().toDouble();
    }
    if (l > 1.0) {
      l = l.round().toDouble();
    }

    final color = HSLColor.fromAHSL(1, h.toDouble(), s, l);

    return color.toColor();
  }
}
