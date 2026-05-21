import 'package:flutter/material.dart';

Widget nextScreenFadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final entryAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

  final exitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
    CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInOut),
  );
  return FadeTransition(
    opacity: entryAnimation,
    child: FadeTransition(opacity: exitAnimation, child: child),
  );
}
